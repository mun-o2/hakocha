import 'package:flutter/material.dart';
import 'package:hakocha/widgets/onboarding/onboarding_page_layout.dart';

/* 5ページ目 */
class CollectOnboardingPage extends StatelessWidget {
  const CollectOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPageLayout(
      title: '思い出を集めよう',
      subtitle: '交換するたび、あなただけの\nプロフィール帳が増えていきます',
      illustrationSpacing: 0,
      illustration: Image.asset('lib/assets/images/letter.png', width: 240),
    );
  }
}
