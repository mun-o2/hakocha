import 'package:flutter/material.dart';
import 'app_colors.dart';

class ProfileCardThemeColor {
  final Color backgroundColor;
  final Color mainColor;

  const ProfileCardThemeColor({
    required this.backgroundColor,
    required this.mainColor,
  });
}

const pinkProfileCardTheme = ProfileCardThemeColor(
  backgroundColor: AppColors.profileCardBackground,
  mainColor: AppColors.pink4,
);

const blueProfileCardTheme = ProfileCardThemeColor(
  backgroundColor: AppColors.profileCardBackgroundBlue,
  mainColor: AppColors.blue3,
);
