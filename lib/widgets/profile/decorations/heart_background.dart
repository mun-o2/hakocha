import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/profile_theme.dart';

//【背景】LoveTalkのハート
class LoveTalkHeart extends StatelessWidget {
  final bool isPink;
  final ProfileCardThemeColor theme;

  const LoveTalkHeart({super.key, required this.isPink, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: (isPink ? 0.88 : 1.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // テーマカラーのふちどり
          Icon(
            Icons.favorite,
            size: (isPink ? 300 : 120),
            color: (isPink ? theme.mainColor : AppColors.purple4).withValues(
              alpha: 0.3,
            ),
            shadows: [
              Shadow(
                color: (isPink ? theme.mainColor : AppColors.purple4)
                    .withValues(alpha: 0.3),
                blurRadius: 7,
              ),
            ],
          ),

          // 白ふちどり
          Icon(
            Icons.favorite,
            size: (isPink ? 282 : 107),
            color: AppColors.white.withValues(alpha: 0.3),
            shadows: [Shadow(color: AppColors.white, blurRadius: 5)],
          ),

          // 白中身
          Icon(
            Icons.favorite,
            size: (isPink ? 240 : 102),
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
