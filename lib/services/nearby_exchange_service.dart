import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hakocha/models/remote_exchange_user.dart';

/// 近距離端末探索サービス
///
/// iOS:
///   Multipeer Connectivity を Swift 側で使用
///
/// その他:
///   UDP ブロードキャストによる簡易プロトタイプ
///
/// 将来的には、Nearby / コード入力のどちらからでも
/// RemoteExchangeUser を取得し、共通の交換確認フローへ合流させる。
class PeerDevice {
  PeerDevice({required this.id, required this.name, this.address})
    : lastSeen = DateTime.now();

  final String id;
  final String name;

  /// iOS MultipeerではIPアドレスを取得しないためnullの場合がある。
  final InternetAddress? address;

  DateTime lastSeen;

  String addressText() {
    return address?.address ?? 'n/a';
  }
}

class NearbyExchangeService {
  NearbyExchangeService({required this.displayName, this.port = 45678});

  final String displayName;
  final int port;

  // ---------------------------------------------------------------------------
  // Flutter Streams
  // ---------------------------------------------------------------------------

  final StreamController<List<PeerDevice>> _peersController =
      StreamController<List<PeerDevice>>.broadcast();

  Stream<List<PeerDevice>> get peersStream => _peersController.stream;

  final StreamController<RemoteExchangeUser> _remoteUserController =
      StreamController<RemoteExchangeUser>.broadcast();

  /// 相手のhakochaユーザー情報を受信したときに流れるStream。
  Stream<RemoteExchangeUser> get remoteUserStream =>
      _remoteUserController.stream;

  final Map<String, PeerDevice> _peers = {};

  // ---------------------------------------------------------------------------
  // iOS Multipeer Connectivity
  // ---------------------------------------------------------------------------

  static const MethodChannel _methodChannel = MethodChannel(
    'hakocha/multipeer/methods',
  );

  static const EventChannel _eventChannel = EventChannel(
    'hakocha/multipeer/events',
  );

  StreamSubscription<dynamic>? _eventSubscription;

  bool get _useMultipeer => Platform.isIOS;

  // ---------------------------------------------------------------------------
  // UDP fallback
  // ---------------------------------------------------------------------------

  RawDatagramSocket? _socket;
  StreamSubscription<RawSocketEvent>? _socketSubscription;

  Timer? _broadcastTimer;
  Timer? _cleanupTimer;

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  Future<void> start() async {
    debugPrint(
      '🔍 [NearbyExchangeService] start() called '
      'displayName=$displayName '
      'useMultipeer=$_useMultipeer',
    );

    if (_useMultipeer) {
      await _startMultipeer();
      return;
    }

    await _startUdp();
  }

  Future<void> stop() async {
    debugPrint('🛑 [NearbyExchangeService] stop() called');

    if (_useMultipeer) {
      await _stopMultipeer();
    } else {
      await _stopUdp();
    }

    _peers.clear();
    _emitPeers();
  }

  void dispose() {
    debugPrint('🗑️ [NearbyExchangeService] dispose()');

    _eventSubscription?.cancel();
    _socketSubscription?.cancel();

    _broadcastTimer?.cancel();
    _cleanupTimer?.cancel();
    _socket?.close();

    if (!_peersController.isClosed) {
      _peersController.close();
    }

    if (!_remoteUserController.isClosed) {
      _remoteUserController.close();
    }
  }

  // ---------------------------------------------------------------------------
  // iOS Multipeer
  // ---------------------------------------------------------------------------

  Future<void> _startMultipeer() async {
    await _eventSubscription?.cancel();

    debugPrint('📱 [NearbyExchangeService] Setting up EventChannel listener');

    // ★ 先にEventChannelをlistenしてからstartする。
    // start直後のfound/userInfoReceivedイベントを取りこぼさないため。
    _eventSubscription = _eventChannel.receiveBroadcastStream().listen(
      _handleMultipeerEvent,
      onError: (Object error) {
        debugPrint('❌ [NearbyExchangeService] EventChannel error: $error');
      },
      onDone: () {
        debugPrint('ℹ️ [NearbyExchangeService] EventChannel closed');
      },
    );

    try {
      debugPrint('📱 [NearbyExchangeService] Invoking MethodChannel.start()');

      await _methodChannel.invokeMethod<void>('start', <String, dynamic>{
        'displayName': displayName,
      });

      debugPrint('✅ [NearbyExchangeService] MethodChannel.start() completed');
    } on PlatformException catch (e) {
      debugPrint(
        '❌ [NearbyExchangeService] MethodChannel PlatformException: '
        '${e.code} ${e.message}',
      );
    } on MissingPluginException catch (e) {
      debugPrint('❌ [NearbyExchangeService] MissingPluginException: $e');
    } catch (e) {
      debugPrint('❌ [NearbyExchangeService] MethodChannel error: $e');
    }
  }

  void _handleMultipeerEvent(dynamic event) {
    try {
      if (event is! Map) {
        debugPrint(
          '⚠️ [NearbyExchangeService] '
          'Unexpected EventChannel data: $event',
        );
        return;
      }

      final map = Map<String, dynamic>.from(event);

      final action = map['action'] as String?;
      final peerId = map['peerId'] as String? ?? '';
      final name =
          map['displayName'] as String? ?? map['name'] as String? ?? peerId;

      debugPrint(
        '📱 [NearbyExchangeService] EventChannel received: '
        'action=$action peerId=$peerId name=$name',
      );

      switch (action) {
        case 'found':
          _handlePeerFound(peerId: peerId, name: name);

        case 'lost':
          _handlePeerLost(peerId);

        case 'connectionStateChanged':
          final connectionState =
              map['connectionState'] as String? ?? 'unknown';

          debugPrint(
            '🔗 [NearbyExchangeService] '
            '$peerId connectionState=$connectionState',
          );

        case 'userInfoReceived':
          _handleUserInfoReceived(map);

        case 'error':
          debugPrint(
            '❌ [NearbyExchangeService] Native error: '
            '${map['message']} '
            '${map['detail']}',
          );

        default:
          debugPrint(
            'ℹ️ [NearbyExchangeService] '
            'Unknown action: $action',
          );
      }
    } catch (e, stackTrace) {
      debugPrint(
        '❌ [NearbyExchangeService] '
        'Failed to process Multipeer event: $e',
      );

      debugPrintStack(stackTrace: stackTrace);
    }
  }

  void _handlePeerFound({required String peerId, required String name}) {
    if (peerId.isEmpty) {
      debugPrint(
        '⚠️ [NearbyExchangeService] '
        'found event has empty peerId',
      );
      return;
    }

    final existing = _peers[peerId];

    if (existing != null) {
      existing.lastSeen = DateTime.now();

      debugPrint('   → Peer already exists. lastSeen updated.');

      return;
    }

    debugPrint('   → New peer added: $name');

    _peers[peerId] = PeerDevice(id: peerId, name: name);

    _emitPeers();
  }

  void _handlePeerLost(String peerId) {
    debugPrint('👋 [NearbyExchangeService] Peer lost: $peerId');

    final removed = _peers.remove(peerId);

    if (removed != null) {
      _emitPeers();
    }
  }

  void _handleUserInfoReceived(Map<String, dynamic> map) {
    final userId = map['userId'] as String? ?? '';
    final name = map['name'] as String? ?? '';
    final exchangeCode = map['exchangeCode'] as String? ?? '';

    if (userId.isEmpty) {
      debugPrint(
        '⚠️ [NearbyExchangeService] '
        'userInfoReceived but userId is empty',
      );
      return;
    }

    final remoteUser = RemoteExchangeUser(
      id: userId,
      name: name,
      exchangeCode: exchangeCode,
    );

    debugPrint('👤 [NearbyExchangeService] remoteUser received!');
    debugPrint('   userId: ${remoteUser.id}');
    debugPrint('   name: ${remoteUser.name}');
    debugPrint('   exchangeCode: ${remoteUser.exchangeCode}');

    if (!_remoteUserController.isClosed) {
      _remoteUserController.add(remoteUser);
    }
  }

  Future<void> _stopMultipeer() async {
    try {
      debugPrint('📱 [NearbyExchangeService] Invoking MethodChannel.stop()');

      await _methodChannel.invokeMethod<void>('stop');

      debugPrint('✅ [NearbyExchangeService] MethodChannel.stop() completed');
    } on MissingPluginException catch (e) {
      debugPrint(
        '❌ [NearbyExchangeService] '
        'stop MissingPluginException: $e',
      );
    } on PlatformException catch (e) {
      debugPrint(
        '❌ [NearbyExchangeService] '
        'stop PlatformException: ${e.message}',
      );
    } catch (e) {
      debugPrint('❌ [NearbyExchangeService] stop error: $e');
    }

    await _eventSubscription?.cancel();
    _eventSubscription = null;
  }

  // ---------------------------------------------------------------------------
  // UDP fallback
  // ---------------------------------------------------------------------------

  Future<void> _startUdp() async {
    _socket = await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      port,
      reuseAddress: true,
      reusePort: true,
    );

    _socket?.broadcastEnabled = true;
    _socket?.readEventsEnabled = true;

    _socketSubscription = _socket?.listen((event) {
      if (event != RawSocketEvent.read) {
        return;
      }

      final datagram = _socket?.receive();

      if (datagram == null) {
        return;
      }

      try {
        final payload = utf8.decode(datagram.data);

        if (!payload.startsWith('hakocha:')) {
          return;
        }

        final parts = payload.split(':');

        if (parts.length < 3) {
          return;
        }

        final id = parts[1];

        final name = parts.sublist(2).join(':');

        // 自分自身のUDPブロードキャストは無視。
        if (id == _myId()) {
          return;
        }

        final existing = _peers[id];

        if (existing != null) {
          existing.lastSeen = DateTime.now();
        } else {
          _peers[id] = PeerDevice(
            id: id,
            name: name,
            address: datagram.address,
          );

          _emitPeers();
        }
      } catch (e) {
        debugPrint(
          '❌ [NearbyExchangeService] '
          'UDP receive error: $e',
        );
      }
    });

    _broadcastTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      try {
        final message = utf8.encode('hakocha:${_myId()}:$displayName');

        _socket?.send(message, InternetAddress('255.255.255.255'), port);
      } catch (e) {
        debugPrint(
          '❌ [NearbyExchangeService] '
          'UDP broadcast error: $e',
        );
      }
    });

    _cleanupTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      final now = DateTime.now();
      final removedIds = <String>[];

      for (final entry in _peers.entries) {
        if (now.difference(entry.value.lastSeen).inSeconds > 8) {
          removedIds.add(entry.key);
        }
      }

      for (final id in removedIds) {
        _peers.remove(id);
      }

      if (removedIds.isNotEmpty) {
        _emitPeers();
      }
    });
  }

  Future<void> _stopUdp() async {
    _broadcastTimer?.cancel();
    _broadcastTimer = null;

    _cleanupTimer?.cancel();
    _cleanupTimer = null;

    await _socketSubscription?.cancel();
    _socketSubscription = null;

    _socket?.close();
    _socket = null;
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  void _emitPeers() {
    if (_peersController.isClosed) {
      return;
    }

    _peersController.add(_peers.values.toList(growable: false));
  }

  String _myId() {
    try {
      return Platform.localHostname;
    } catch (_) {
      return DateTime.now().millisecondsSinceEpoch.toString();
    }
  }
}
