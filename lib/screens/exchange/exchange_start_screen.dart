import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/models/remote_exchange_user.dart';
import 'package:hakocha/models/user_profile.dart';
import 'package:hakocha/providers/exchange_provider.dart';
import 'package:hakocha/screens/exchange/exchange_code_input_screen.dart';
import 'package:hakocha/services/nearby_exchange_service.dart';
import 'package:provider/provider.dart';

class ExchangeStartScreen extends StatefulWidget {
  const ExchangeStartScreen({super.key});

  @override
  State<ExchangeStartScreen> createState() => _ExchangeStartScreenState();
}

class _ExchangeStartScreenState extends State<ExchangeStartScreen>
    with SingleTickerProviderStateMixin {
  late final NearbyExchangeService _nearbyService;

  StreamSubscription<List<PeerDevice>>? _peersSubscription;
  StreamSubscription<RemoteExchangeUser>? _remoteUserSubscription;

  // 探索中アニメーション
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  // 交換成功音
  final AudioPlayer _audioPlayer = AudioPlayer();

  Timer? _debugMatchTimer; // TODO: DEBUG削除

  @override
  void initState() {
    super.initState();

    _setupAnimation();
    _setupNearbyExchange();

    _startDebugMatch(); // TODO: DEBUG削除
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _setupNearbyExchange() {
    final name = Platform.localHostname;

    debugPrint('🚀 [ExchangeStartScreen] initState: displayName=$name');

    _nearbyService = NearbyExchangeService(displayName: name);

    // 近くの端末を検出
    _peersSubscription = _nearbyService.peersStream.listen((list) {
      debugPrint(
        '📋 [ExchangeStartScreen] '
        'peersStream updated: ${list.length} peer(s)',
      );

      for (final peer in list) {
        debugPrint('   - ${peer.name} (${peer.id})');
      }
    });

    // 本番：
    // 相手ユーザー情報を受信したら交換成功
    _remoteUserSubscription = _nearbyService.remoteUserStream.listen(
      _handleRemoteUserReceived,
    );

    debugPrint('🔍 [ExchangeStartScreen] Starting nearby service...');

    _nearbyService.start();
  }

  /// 本番通信成功時
  Future<void> _handleRemoteUserReceived(RemoteExchangeUser remoteUser) async {
    debugPrint(
      '🎉 [ExchangeStartScreen] 相手情報受信！ '
      'name=${remoteUser.name}, id=${remoteUser.id}',
    );

    if (!mounted) return;

    // 本物の通信が先に成功した場合、
    // デバッグタイマーが後から発火しないように止める
    _debugMatchTimer?.cancel(); // TODO: DEBUG削除

    await _playSuccessFeedback();

    if (!mounted) return;

    final user = UserProfile(
      id: remoteUser.id,
      name: remoteUser.name,
      iconUrl: '',
      exchangeCode: remoteUser.exchangeCode,
      themeColor: ProfileThemeColor.pink,
    );

    debugPrint('🎉 [ExchangeStartScreen] real matchUser()');

    context.read<ExchangeProvider>().matchUser(user);
  }

  /// 交換成功時の演出
  Future<void> _playSuccessFeedback() async {
    // ふわふわアニメーション停止
    _animationController.stop();

    // 振動は音とは独立して実行
    HapticFeedback.mediumImpact();

    // 音が失敗しても処理全体を止めない
    try {
      await _audioPlayer.play(AssetSource('sounds/exchange_success.mp3'));

      debugPrint('🔊 [ExchangeStartScreen] success sound played');
    } catch (e) {
      debugPrint('❌ [ExchangeStartScreen] sound error: $e');
    }

    // 成功演出の余韻
    await Future.delayed(const Duration(milliseconds: 180));
  }

  /// 実機1台でも交換演出を確認するための仮処理
  // TODO: DEBUG削除
  void _startDebugMatch() {
    _debugMatchTimer = Timer(const Duration(seconds: 3), () async {
      if (!mounted) return;

      debugPrint('🧪 [DEBUG] 3秒経過 → ダミー交換成功');

      try {
        await _playSuccessFeedback();
      } catch (e) {
        debugPrint('❌ [DEBUG] feedback error: $e');
      }

      if (!mounted) return;

      debugPrint('🎉 [DEBUG] simulateMatch()');

      // 音が鳴らなくても必ず交換完了へ進む
      context.read<ExchangeProvider>().simulateMatch();
    });
  }

  @override
  void dispose() {
    _debugMatchTimer?.cancel(); // TODO: DEBUG削除

    _peersSubscription?.cancel();
    _remoteUserSubscription?.cancel();

    _animationController.dispose();
    _audioPlayer.dispose();

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
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              'lib/assets/images/sharescreen_image85.png',
              width: 280,
              fit: BoxFit.contain,
            ),
          ),
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
}
