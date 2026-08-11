import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/constants/app_text_styles.dart';
import 'package:hakocha/widgets/onboarding/onboarding_page_layout.dart';

/* 4ページ目 */
class ColorOnboardingPage extends StatelessWidget {
  final String selectedColor;
  final ValueChanged<String> onColorChanged;

  const ColorOnboardingPage({
    super.key,
    required this.selectedColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingPageLayout(
      title: 'プロフ帳のカラーを選択',
      subtitle: 'お互いのスマホを近付けるだけで\nプロフィール帳を交換できます',
      illustrationSpacing: 28,
      illustration: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ColorChoice(
            label: 'ピンク',
            imageAsset: 'lib/assets/images/profilebook_pink.png',
            value: 'pink',
            selected: selectedColor == 'pink',
            selectedColor: AppColors.pink4,
            onTap: () => onColorChanged('pink'),
          ),

          const SizedBox(width: 28),

          _ColorChoice(
            label: 'ブルー',
            imageAsset: 'lib/assets/images/profilebook_blue.png',
            value: 'blue',
            selected: selectedColor == 'blue',
            selectedColor: AppColors.blue4,
            onTap: () => onColorChanged('blue'),
          ),
        ],
      ),
    );
  }
}

class _ColorChoice extends StatelessWidget {
  final String label;
  final String imageAsset;
  final String value;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;

  const _ColorChoice({
    required this.label,
    required this.imageAsset,
    required this.value,
    required this.selected,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Image.asset(imageAsset, width: 90, height: 115, fit: BoxFit.contain),

          const SizedBox(height: 12),

          Row(
            children: [
              Container(
                width: 17,
                height: 17,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? selectedColor : Colors.grey.shade400,
                  ),
                ),
                child: selected
                    ? Center(
                        child: Container(
                          width: 9,
                          height: 9,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedColor,
                          ),
                        ),
                      )
                    : null,
              ),

              const SizedBox(width: 8),

              Text(label, style: AppTextStyles.onboardingSubtitle),
            ],
          ),
        ],
      ),
    );
  }
}
