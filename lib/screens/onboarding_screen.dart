import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/screens/onboarding/pages/exchange_onboarding_page.dart';
import 'package:hakocha/screens/onboarding/pages/welcome_onboarding_page.dart';
import 'package:hakocha/screens/onboarding/pages/yours_onboarding_page.dart';
import 'package:hakocha/screens/onboarding/profile_setup_onboarding_screen.dart';
import 'package:hakocha/widgets/onboarding/account_register_buttons.dart';
import 'package:hakocha/widgets/onboarding/onboarding_dots.dart';
import 'package:hakocha/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  final AuthService _authService = AuthService();

  int _page = 0;
  _AuthProvider? _authenticatingProvider;

  bool get _isAuthenticating => _authenticatingProvider != null;

  List<Widget> get pages => [
    const WelcomeOnboardingPage(),
    const ExchangeOnboardingPage(),
    const YoursOnboardingPage(),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    if (_isAuthenticating) return;

    setState(() => _authenticatingProvider = _AuthProvider.google);

    try {
      final credential = await _authService.signInWithGoogle();
      if (credential.user == null || !mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ProfileSetupOnboardingScreen()),
      );
    } on GoogleSignInException catch (error) {
      if (!mounted || error.code == GoogleSignInExceptionCode.canceled) return;
      _showSignInError();
      debugPrint('Google Sign In error: $error');
    } catch (error) {
      if (!mounted) return;
      _showSignInError();
      debugPrint('Google Sign In error: $error');
    } finally {
      if (mounted) setState(() => _authenticatingProvider = null);
    }
  }

  Future<void> _signInWithApple() async {
    if (_isAuthenticating) return;

    setState(() => _authenticatingProvider = _AuthProvider.apple);

    try {
      final credential = await _authService.signInWithApple();
      if (credential.user == null || !mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ProfileSetupOnboardingScreen()),
      );
    } on FirebaseAuthException catch (error) {
      if (!mounted || _isCancellation(error.code)) return;
      _showSignInError(provider: _AuthProvider.apple);
      debugPrint('Apple Sign In error: $error');
    } catch (error) {
      if (!mounted) return;
      _showSignInError(provider: _AuthProvider.apple);
      debugPrint('Apple Sign In error: $error');
    } finally {
      if (mounted) setState(() => _authenticatingProvider = null);
    }
  }

  bool _isCancellation(String code) {
    return code == 'web-context-cancelled' ||
        code == 'canceled' ||
        code == 'cancelled';
  }

  void _showSignInError({_AuthProvider provider = _AuthProvider.google}) {
    final message = provider == _AuthProvider.apple
        ? 'Appleログインを利用できません。設定完了後にもう一度お試しください。'
        : 'Googleログインに失敗しました。もう一度お試しください。';
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPink,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    _page = index;
                  });
                },
                children: pages,
              ),
            ),

            OnboardingDots(currentPage: _page, pageCount: pages.length),

            const SizedBox(height: 70),

            AccountRegisterButtons(
              canRegister: !_isAuthenticating,
              isAppleLoading: _authenticatingProvider == _AuthProvider.apple,
              isGoogleLoading: _authenticatingProvider == _AuthProvider.google,
              // Capabilityは設定担当者がXcodeで追加する。コード側は先に有効化しておく。
              canUseApple: true,
              onApplePressed: _signInWithApple,

              onGooglePressed: _signInWithGoogle,
              onLoginPressed: _signInWithGoogle,
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

enum _AuthProvider { apple, google }
