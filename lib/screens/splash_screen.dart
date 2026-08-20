import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hakocha/constants/app_colors.dart';

typedef SignedInResolver = Future<bool> Function();

/// アプリケーションのスプラッシュスクリーン
///
/// 起動時に表示され、約1.5〜2秒後にフェードアニメーションで
/// ホーム画面へ遷移します。
class SplashScreen extends StatefulWidget {
  final SignedInResolver? resolveSignedIn;

  const SplashScreen({super.key, this.resolveSignedIn});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // フェードアニメーションの設定
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _completeSplash();
  }

  Future<void> _completeSplash() async {
    final signedInFuture =
        widget.resolveSignedIn?.call() ??
        Future<bool>.value(FirebaseAuth.instance.currentUser != null);

    await Future<void>.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    await _animationController.forward();
    if (!mounted) return;

    final signedIn = await signedInFuture;
    if (!mounted) return;

    Navigator.of(
      context,
    ).pushReplacementNamed(signedIn ? '/home' : '/onboarding');
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: FadeTransition(
        opacity: _opacityAnimation,
        child: Stack(
          children: [
            Positioned(
              top: 265,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'lib/assets/images/shareme_logo.png',
                  width: 343,
                  height: 343,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
