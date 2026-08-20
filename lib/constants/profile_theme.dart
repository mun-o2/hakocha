import 'package:flutter/material.dart';
import 'app_colors.dart';

class ProfileCardThemeColor {
  final Color backgroundColor;
  final Color mainColor;
  final Color snsIconColor;

  const ProfileCardThemeColor({
    required this.backgroundColor,
    required this.mainColor,
    required this.snsIconColor,
  });
}

const pinkProfileCardTheme = ProfileCardThemeColor(
  backgroundColor: AppColors.profileCardBackground,
  mainColor: AppColors.pink4,
  snsIconColor: AppColors.profileCardSNSIconPink,
);

const blueProfileCardTheme = ProfileCardThemeColor(
  backgroundColor: AppColors.profileCardBackgroundBlue,
  mainColor: AppColors.blue3,
  snsIconColor: AppColors.profileCardSNSIconBlue,
);
