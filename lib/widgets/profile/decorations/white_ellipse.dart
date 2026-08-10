import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

//【背景】白い楕円
class WhiteEllipse extends StatelessWidget {
  const WhiteEllipse({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: AppColors.white.withValues(alpha: 0.9),
        shape: const OvalBorder(),
        shadows: [
          BoxShadow(
            color: AppColors.white.withValues(alpha: 0.8),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}
