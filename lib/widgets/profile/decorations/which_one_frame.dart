import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/profile_theme.dart';

//【背景】Which One?等のフレーム　高さ・横幅・色指定可能
class ProfileWhichOneFrame extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;
  final ProfileCardThemeColor theme;

  const ProfileWhichOneFrame({
    super.key,
    this.child,
    required this.theme,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _ProfileWhichOnePainter(theme: theme),
        child: Padding(padding: const EdgeInsets.all(10), child: child),
      ),
    );
  }
}

//Which One?等のフレームを描写
class _ProfileWhichOnePainter extends CustomPainter {
  final ProfileCardThemeColor theme;

  _ProfileWhichOnePainter({required this.theme});
  @override
  void paint(Canvas canvas, Size size) {
    const double cut = 10;

    // 外側（白）
    final outerPath = Path()
      ..moveTo(cut, 0)
      ..lineTo(size.width - cut, 0)
      ..arcToPoint(
        Offset(size.width, cut),
        radius: const Radius.circular(cut),
        clockwise: false,
      )
      ..lineTo(size.width, size.height - cut)
      ..arcToPoint(
        Offset(size.width - cut, size.height),
        radius: const Radius.circular(cut),
        clockwise: false,
      )
      ..lineTo(cut, size.height)
      ..arcToPoint(
        Offset(0, size.height - cut),
        radius: const Radius.circular(cut),
        clockwise: false,
      )
      ..lineTo(0, cut)
      ..arcToPoint(
        Offset(cut, 0),
        radius: const Radius.circular(cut),
        clockwise: false,
      )
      ..close();

    canvas.drawPath(outerPath, Paint()..color = AppColors.white);

    // 内側のテーマカラー線
    final innerPath = Path()
      ..moveTo(cut + 8, 8)
      ..lineTo(size.width - cut - 8, 8)
      ..arcToPoint(
        Offset(size.width - 8, cut + 8),
        radius: const Radius.circular(cut),
        clockwise: false,
      )
      ..lineTo(size.width - 8, size.height - cut - 8)
      ..arcToPoint(
        Offset(size.width - cut - 8, size.height - 8),
        radius: const Radius.circular(cut),
        clockwise: false,
      )
      ..lineTo(cut + 8, size.height - 8)
      ..arcToPoint(
        Offset(8, size.height - cut - 8),
        radius: const Radius.circular(cut),
        clockwise: false,
      )
      ..lineTo(8, cut + 8)
      ..arcToPoint(
        Offset(cut + 8, 8),
        radius: const Radius.circular(cut),
        clockwise: false,
      )
      ..close();

    canvas.drawPath(
      innerPath,
      Paint()
        ..color = theme.backgroundColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
