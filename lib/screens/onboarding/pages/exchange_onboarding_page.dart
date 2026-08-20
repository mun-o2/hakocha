import 'package:flutter/material.dart';
import 'package:hakocha/widgets/onboarding/onboarding_page_layout.dart';

/* 2ページ目 */
class ExchangeOnboardingPage extends StatelessWidget {
  const ExchangeOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPageLayout(
      title: 'スマホを近づけるだけ',
      subtitle: 'お互いのスマホを近付けるだけで\nプロフィール帳を交換できます',
      illustrationSpacing: 20,
      illustration: Image.asset(
        'lib/assets/images/sharescreen_image85.png',
        width: 240,
      ),
    );
  }
}
