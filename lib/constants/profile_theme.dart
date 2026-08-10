import 'package:flutter/material.dart';
import 'app_colors.dart';

class ProfileCardThemeColor {
  final Color backgroundColor;
  final Color mainColor;
  final Color SNSIconColor;

  const ProfileCardThemeColor({
    required this.backgroundColor,
    required this.mainColor,
    required this.SNSIconColor,
  });
}

const pinkProfileCardTheme = ProfileCardThemeColor(
  backgroundColor: AppColors.profileCardBackground,
  mainColor: AppColors.pink4,
  SNSIconColor: AppColors.profileCardSNSIconPink,
);

const blueProfileCardTheme = ProfileCardThemeColor(
  backgroundColor: AppColors.profileCardBackgroundBlue,
  mainColor: AppColors.blue3,
  SNSIconColor: AppColors.profileCardSNSIconBlue,
);
