import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

import '../../../constants/profile_theme.dart';

//プロフィールカードのベース
// カード全体
class ProfileCardBody extends StatelessWidget {
  final bool isLeft;
  final Widget child;
  final ProfileCardThemeColor theme;

  const ProfileCardBody({
    super.key,
    this.isLeft = true,
    required this.child,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    //左側に出っ張りがある（表）
    if (isLeft) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          // 出っ張り
          Positioned(
            left: -13,
            top: 0,
            child: Container(
              width: 70,
              height: 450,
              decoration: BoxDecoration(
                color: theme.mainColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          // 穴
          Positioned(
            left: 0,
            top: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 23,
            right: 0,
            top: 0,
            bottom: 0,
            child: ProfileCardMain(isLeft: true, theme: theme, child: child),
          ),
        ],
      );
    }
    //右側に出っ張りがある（裏）
    else {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          // 出っ張り
          Positioned(
            right: -13,
            top: 0,
            child: Container(
              width: 70,
              height: 450,
              decoration: BoxDecoration(
                color: theme.mainColor,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),

          // 穴
          Positioned(
            right: 0,
            top: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 23,
            top: 0,
            bottom: 0,
            child: ProfileCardMain(isLeft: false, theme: theme, child: child),
          ),
        ],
      );
    }
  }
}

// カード本体
class ProfileCardMain extends StatelessWidget {
  final bool isLeft;
  final Widget child;
  final ProfileCardThemeColor theme;

  const ProfileCardMain({
    super.key,
    this.isLeft = true,
    required this.child,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.mainColor,
        borderRadius: BorderRadius.only(
          topLeft: isLeft ? Radius.zero : const Radius.circular(30),
          topRight: isLeft ? const Radius.circular(30) : Radius.zero,
          bottomLeft: const Radius.circular(30),
          bottomRight: const Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(4),

      child: Container(
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: isLeft ? Radius.zero : const Radius.circular(27),
            topRight: isLeft ? const Radius.circular(27) : Radius.zero,
            bottomLeft: const Radius.circular(27),
            bottomRight: const Radius.circular(27),
          ),
        ),
        child: child,
      ),
    );
  }
}
