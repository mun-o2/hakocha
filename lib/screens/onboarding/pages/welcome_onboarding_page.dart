import 'package:flutter/material.dart';
import 'package:hakocha/widgets/onboarding/onboarding_page_layout.dart';

/* 1ページ目 */
class WelcomeOnboardingPage extends StatelessWidget {
  const WelcomeOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPageLayout(
      title: 'シェアmeへようこそ',
      subtitle: 'あの頃のプロフィール帳を、\nデジタルへ',
      illustrationSpacing: 60,
      illustration: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/assets/images/onboarding/heart.png', width: 90),

          const SizedBox(width: 55),

          Image.asset('lib/assets/images/onboarding/star.png', width: 90),
        ],
      ),
    );
  }
}
