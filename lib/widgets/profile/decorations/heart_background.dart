import 'package:flutter/material.dart';
import '../../../constants/profile_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

//【背景】LoveTalkのハート
class LoveTalkHeart extends StatelessWidget {
  final bool isPurple;
  final ProfileCardThemeColor theme;
  final double? width;
  final double? height;

  const LoveTalkHeart({
    super.key,
    required this.isPurple,
    required this.theme,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // 白いハート
    final whitePath = isPurple
        ? 'lib/assets/images/profile/small_heart_background.svg'
        : 'lib/assets/images/profile/big_heart_background.svg';

    final String outlinePath;

    // 縁取り
    if (isPurple) {
      outlinePath = 'lib/assets/images/profile/heart_outline_purple.svg';
    } else if (theme == pinkProfileCardTheme) {
      outlinePath = 'lib/assets/images/profile/heart_outline_pink.svg';
    } else {
      outlinePath = 'lib/assets/images/profile/heart_outline_blue.svg';
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        // 白いハート
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: SvgPicture.asset(whitePath),
        ),

        // ぼかした縁取り
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: SvgPicture.asset(outlinePath),
        ),
      ],
    );
  }
}
