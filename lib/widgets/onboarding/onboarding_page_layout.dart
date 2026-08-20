import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_text_styles.dart';

class OnboardingPageLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget illustration;
  final double illustrationSpacing;

  const OnboardingPageLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.illustration,
    this.illustrationSpacing = 56, // デフォルト
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          const SizedBox(height: 120),

          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.onboardingTitle,
          ),

          const SizedBox(height: 24),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.onboardingSubtitle,
          ),

          SizedBox(height: illustrationSpacing),

          illustration,

          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
