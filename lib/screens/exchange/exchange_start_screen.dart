import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/models/remote_exchange_user.dart';
import 'package:hakocha/screens/exchange/exchange_code_input_screen.dart';
import 'package:hakocha/screens/exchange/exchange_match_screen.dart';
import 'package:hakocha/services/nearby_exchange_service.dart';

class ExchangeStartScreen extends StatefulWidget {
  const ExchangeStartScreen({super.key});

  @override
  State<ExchangeStartScreen> createState() => _ExchangeStartScreenState();
}

class _ExchangeStartScreenState extends State<ExchangeStartScreen> {
  late final NearbyExchangeService _nearbyService;

  StreamSubscription<List<PeerDevice>>? _peersSubscription;
  StreamSubscription<RemoteExchangeUser>? _remoteUserSubscription;

  List<PeerDevice> _peers = [];

  bool _isNavigatingToMatch = false;

  @override
  void initState() {
    super.initState();

    final name = Platform.localHostname;

    debugPrint('🚀 [ExchangeStartScreen] initState: displayName=$name');

    _nearbyService = NearbyExchangeService(displayName: name);

    // 近くの端末一覧
    _peersSubscription = _nearbyService.peersStream.listen((list) {
      debugPrint(
        '📋 [ExchangeStartScreen] '
        'peersStream updated: ${list.length} peer(s)',
      );

      for (final peer in list) {
        debugPrint('   - ${peer.name} (${peer.id})');
      }

      if (!mounted) return;

      setState(() {
        _peers = list;
      });
    });

    // ★ 相手のhakochaユーザー情報を受信
    _remoteUserSubscription = _nearbyService.remoteUserStream.listen(
      _handleRemoteUserReceived,
    );

    debugPrint('🔍 [ExchangeStartScreen] Starting nearby service...');

    _nearbyService.start();
  }

  void _handleRemoteUserReceived(RemoteExchangeUser user) {
    debugPrint(
      '👤 [ExchangeStartScreen] '
      'remoteUser received: ${user.name} (${user.id})',
    );

    if (!mounted) {
      return;
    }

    // 同じuserInfoが複数回来ても、
    // 確認画面を何枚も開かないようにする。
    if (_isNavigatingToMatch) {
      debugPrint(
        'ℹ️ [ExchangeStartScreen] '
        'Already navigating to match screen.',
      );
      return;
    }

    _isNavigatingToMatch = true;

    debugPrint(
      '🚀 [ExchangeStartScreen] '
      'Navigating to ExchangeMatchScreen: ${user.name}',
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ExchangeMatchScreen(matchedUser: user)),
    ).then((_) {
      debugPrint(
        '↩️ [ExchangeStartScreen] '
        'Returned from ExchangeMatchScreen',
      );

      _isNavigatingToMatch = false;
    });
  }

  @override
  void dispose() {
    debugPrint('🛑 [ExchangeStartScreen] dispose: stopping service');

    _peersSubscription?.cancel();
    _remoteUserSubscription?.cancel();

    _nearbyService.stop();
    _nearbyService.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFFBF8FF),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 80),

            _buildTitle(),

            const SizedBox(height: 24),

            _buildIllustration(),

            const SizedBox(height: 32),

            _buildActionArea(context),

            const SizedBox(height: 16),

            // 今はデバッグ用。
            // userInfo交換が安定したら削除してOK。
            _buildPeersList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'スマホを近づけて\nタップしてシェア！',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF4D4643),
        fontSize: 24,
        fontFamily: 'Noto Sans JP',
        fontWeight: FontWeight.w400,
        height: 2,
      ),
    );
  }

  Widget _buildIllustration() {
    return SizedBox(
      height: 260,
      child: Center(
        child: Image.asset(
          'lib/assets/images/sharescreen_image85.png',
          width: 280,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildActionArea(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 300,
          height: 140,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: ShapeDecoration(
            color: const Color(0xFFF3E9FD),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: AppColors.purple5),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '交換コードで受け取る',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.purple5,
                  fontSize: 20,
                  fontFamily: 'Noto Sans JP',
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 16),

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.purple5,
                  backgroundColor: AppColors.backgroundWhite,
                  side: const BorderSide(color: AppColors.purple5, width: 2),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ExchangeCodeInputScreen(),
                    ),
                  );
                },
                child: const Text(
                  'コードを入力する',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPeersList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              '検出した端末： ${_peers.length}',
              style: const TextStyle(fontSize: 16),
            ),
          ),

          Expanded(
            child: Card(
              elevation: 2,
              child: _peers.isEmpty
                  ? const Center(child: Text('見つかりません'))
                  : ListView.separated(
                      itemCount: _peers.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final peer = _peers[index];

                        return ListTile(
                          title: Text(peer.name),
                          subtitle: Text(peer.addressText()),
                          trailing: Text(
                            peer.id,
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
