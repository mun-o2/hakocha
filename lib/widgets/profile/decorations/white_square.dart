import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

//【背景】白い四角
class ProfileWhiteSquare extends StatelessWidget {
  const ProfileWhiteSquare({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.7),
        boxShadow: [
          BoxShadow(
            color: AppColors.white.withValues(alpha: 0.8),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}
