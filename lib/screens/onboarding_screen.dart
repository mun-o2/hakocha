import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/screens/onboarding/pages/exchange_onboarding_page.dart';
import 'package:hakocha/screens/onboarding/pages/welcome_onboarding_page.dart';
import 'package:hakocha/screens/onboarding/pages/yours_onboarding_page.dart';
import 'package:hakocha/screens/onboarding/profile_setup_onboarding_screen.dart';
import 'package:hakocha/widgets/onboarding/account_register_buttons.dart';
import 'package:hakocha/widgets/onboarding/onboarding_dots.dart';
import 'package:hakocha/services/auth_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  final AuthService _authService = AuthService();

  int _page = 0;

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
              canRegister: true,
              // Developer側のSign in with Apple capability設定完了後に有効化する。
              canUseApple: false,
              // appleの登録
              onApplePressed: () async {
                try {
                  final credential = await _authService.signInWithApple();

                  final user = credential.user;

                  if (user == null) return;

                  // TODO: 選択したカラーやユーザー情報をFirestoreへ保存

                  if (!context.mounted) return;
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const ProfileSetupOnboardingScreen(),
                    ),
                  );
                } catch (e) {
                  debugPrint('Apple Sign In error: $e');
                }
              },

              // googleの登録
              onGooglePressed: () async {
                try {
                  final credential = await _authService.signInWithGoogle();

                  final user = credential.user;

                  if (user == null) return;
                  if (!context.mounted) return;

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const ProfileSetupOnboardingScreen(),
                    ),
                  );
                } catch (e) {
                  debugPrint('Google Sign In error: $e');
                }
              },
              onLoginPressed: () {
                // TODO: ログイン画面へ
              },
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
