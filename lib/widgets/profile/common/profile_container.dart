import 'package:flutter/material.dart';

//フォーマット　高さ・横幅・背景・質問項目指定可能
class ProfileContainer extends StatelessWidget {
  final Widget background;
  final Widget child;

  final Widget? title;

  final double width;
  final double height;

  const ProfileContainer({
    super.key,
    required this.background,
    required this.child,
    this.title,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(child: background),

          if (title != null) title!,

          Positioned.fill(child: child),
        ],
      ),
    );
  }
}
