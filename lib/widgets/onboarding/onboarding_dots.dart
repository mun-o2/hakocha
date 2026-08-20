import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';

class OnboardingDots extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  const OnboardingDots({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 7),
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index
                ? AppColors.pink4
                : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}
