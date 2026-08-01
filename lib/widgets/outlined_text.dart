import 'package:flutter/material.dart';

class OutlinedText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color mainColor;
  final Color outlineColor;
  final double strokeWidth;

  const OutlinedText({
    super.key,
    required this.text,
    required this.style,
    required this.mainColor,
    required this.outlineColor,
    this.strokeWidth = 4.5,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: style.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = outlineColor,
          ),
        ),
        Text(text, style: style.copyWith(color: mainColor)),
      ],
    );
  }
}
