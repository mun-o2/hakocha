import 'package:flutter/material.dart';
import 'package:hakocha/widgets/onboarding/onboarding_page_layout.dart';

/* 3ページ目 */
class YoursOnboardingPage extends StatelessWidget {
  const YoursOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPageLayout(
      title: 'あなただけのプロフ帳を',
      subtitle: '基本情報だけでなく、\n自分だけの質問ができます',
      illustrationSpacing: 60,
      illustration: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/assets/images/onboarding/tape_pink.png', width: 158),

          const SizedBox(width: 10),

          Image.asset('lib/assets/images/onboarding/tape_blue.png', width: 158),
        ],
      ),
    );
  }
}
