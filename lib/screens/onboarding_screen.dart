import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/screens/onboarding/pages/collect_onboarding_page.dart';
import 'package:hakocha/screens/onboarding/pages/color_onboarding_page.dart';
import 'package:hakocha/screens/onboarding/pages/exchange_onboarding_page.dart';
import 'package:hakocha/screens/onboarding/pages/welcome_onboarding_page.dart';
import 'package:hakocha/screens/onboarding/pages/yours_onboarding_page.dart';
import 'package:hakocha/widgets/onboarding/account_register_buttons.dart';
import 'package:hakocha/widgets/onboarding/onboarding_dots.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool _hasReachedLastPage = false;
  String _selectedColor = 'pink';

  int _page = 0;

  List<Widget> get pages => [
    const WelcomeOnboardingPage(),
    const ExchangeOnboardingPage(),
    const YoursOnboardingPage(),
    ColorOnboardingPage(
      selectedColor: _selectedColor,
      onColorChanged: (color) {
        setState(() {
          _selectedColor = color;
        });
      },
    ),
    const CollectOnboardingPage(),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool canRegister = _hasReachedLastPage;

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

                    if (index == pages.length - 1) {
                      _hasReachedLastPage = true;
                    }
                  });
                },
                children: pages,
              ),
            ),

            OnboardingDots(currentPage: _page, pageCount: pages.length),

            const SizedBox(height: 70),

            AccountRegisterButtons(
              canRegister: canRegister,
              onApplePressed: () {
                // TODO: Apple Sign In
              },
              onGooglePressed: () {
                // TODO: Google Sign In
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
