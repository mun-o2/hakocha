import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

/// シンプルなUDPブロードキャストによる近隣端末検出サービス（軽量プロトタイプ）
///
/// - start(): ソケットを開いて定期的に自身の存在をブロードキャストし、同ポートからのパケットを受信して端末一覧を更新します。
/// - stop(): すべて停止します。
///
/// 注意: iOS のローカルネットワーク許可（Info.plist）や Android のネットワーク権限が必要です。

class PeerDevice {
  final String id;
  final String name;
  final InternetAddress? address; // may be null for platform-native discovery
  DateTime lastSeen;

  PeerDevice({
    required this.id,
    required this.name,
    this.address,
  }) : lastSeen = DateTime.now();

  String addressText() => address?.address ?? 'n/a';
}

class NearbyExchangeService {
  NearbyExchangeService({required this.displayName, this.port = 45678});

  final String displayName;
  final int port;

  RawDatagramSocket? _socket;
  Timer? _broadcastTimer;
  Timer? _cleanupTimer;
  final Map<String, PeerDevice> _peers = {};
  final StreamController<List<PeerDevice>> _peersController = StreamController.broadcast();
  // iOS Multipeer channels
  static const MethodChannel _methodChannel = MethodChannel('hakocha/multipeer/methods');
  static const EventChannel _eventChannel = EventChannel('hakocha/multipeer/events');
  StreamSubscription? _eventSub;
  final bool _useMultipeer = Platform.isIOS;

  Stream<List<PeerDevice>> get peersStream => _peersController.stream;

  Future<void> start() async {
    print('🔍 [NearbyExchangeService] start() called, displayName=$displayName, useMultipeer=$_useMultipeer');
    if (_useMultipeer) {
      // start native Multipeer on iOS via MethodChannel
      print('📱 [NearbyExchangeService] Setting up EventChannel listener');
      _eventSub = _eventChannel.receiveBroadcastStream().listen((dynamic event) {
        try {
          final Map<dynamic,dynamic> map = event as Map<dynamic,dynamic>;
          final action = map['action'] as String?;
          final peerId = map['peerId'] as String? ?? '';
          final name = map['displayName'] as String? ?? peerId;
          print('📱 [NearbyExchangeService] EventChannel event received: action=$action, peerId=$peerId, name=$name');
          if (action == 'found') {
            final existing = _peers[peerId];
            if (existing != null) {
              existing.lastSeen = DateTime.now();
              print('   → Peer already exists, updated lastSeen');
            } else {
              print('   → New peer added');
              _peers[peerId] = PeerDevice(id: peerId, name: name, address: null);
              _emitPeers();
            }
          } else if (action == 'lost') {
            print('   → Peer removed');
            _peers.remove(peerId);
            _emitPeers();
          }
        } catch (e) {
          print('❌ [NearbyExchangeService] EventChannel error: $e');
        }
      });

      try {
        print('📱 [NearbyExchangeService] Invoking MethodChannel.start()');
        await _methodChannel.invokeMethod('start', {'displayName': displayName});
        print('✅ [NearbyExchangeService] MethodChannel.start() completed');
      } catch (e) {
        print('❌ [NearbyExchangeService] MethodChannel error: $e');
      }
      return;
    }
    // bind to any address so we can receive broadcasts
    _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port, reuseAddress: true, reusePort: true);
    _socket?.readEventsEnabled = true;

    _socket?.listen((event) {
      if (event == RawSocketEvent.read) {
        final datagram = _socket?.receive();
        if (datagram == null) return;
        try {
          final payload = utf8.decode(datagram.data);
          if (!payload.startsWith('hakocha:')) return;
          // format: hakocha:<id>:<name>
          final parts = payload.split(':');
          if (parts.length < 3) return;
          final id = parts[1];
          final name = parts.sublist(2).join(':');

          final addr = datagram.address;
          final existing = _peers[id];
          if (existing != null) {
            existing.lastSeen = DateTime.now();
          } else {
            _peers[id] = PeerDevice(id: id, name: name, address: addr);
            _emitPeers();
          }
        } catch (_) {
          // ignore malformed
        }
      }
    });

    // periodic broadcast own presence
    _broadcastTimer = Timer.periodic(const Duration(seconds: 2), (_) async {
      try {
        final msg = utf8.encode('hakocha:${_myId()}:$displayName');
        // broadcast address
        _socket?.send(msg, InternetAddress('255.255.255.255'), port);
      } catch (_) {}
    });

    // cleanup stale peers
    _cleanupTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      final now = DateTime.now();
      final removed = <String>[];
      _peers.forEach((k, v) {
        if (now.difference(v.lastSeen).inSeconds > 8) removed.add(k);
      });
      for (final k in removed) {
        _peers.remove(k);
      }
      if (removed.isNotEmpty) _emitPeers();
    });
  }

  Future<void> stop() async {
    print('🛑 [NearbyExchangeService] stop() called');
    if (_useMultipeer) {
      try {
        print('📱 [NearbyExchangeService] Invoking MethodChannel.stop()');
        await _methodChannel.invokeMethod('stop');
        print('✅ [NearbyExchangeService] MethodChannel.stop() completed');
      } catch (e) {
        print('❌ [NearbyExchangeService] stop error: $e');
      }
      await _eventSub?.cancel();
      _eventSub = null;
      _peers.clear();
      _emitPeers();
      return;
    }

    _broadcastTimer?.cancel();
    _cleanupTimer?.cancel();
    _socket?.close();
    _socket = null;
    _peers.clear();
    _emitPeers();
  }

  void _emitPeers() {
    if (!_peersController.isClosed) {
      _peersController.add(_peers.values.toList(growable: false));
    }
  }

  String _myId() {
    // stable id for this run — use hostname when available
    try {
      return Platform.localHostname;
    } catch (_) {
      return DateTime.now().millisecondsSinceEpoch.toString();
    }
  }

  void dispose() {
    _peersController.close();
    stop();
  }
}
