import 'package:flutter/material.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/profile_theme.dart';

class ProfileInputHeart extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileInputHeart({
    super.key,
    required this.value,
    required this.onChanged,
    required this.editable,
    required this.theme,
  });

  @override
  State<ProfileInputHeart> createState() => _ProfileInputHeartState();
}

class _ProfileInputHeartState extends State<ProfileInputHeart> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant ProfileInputHeart oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125,
      child: widget.editable
          ? TextField(
              controller: controller,
              maxLines: 2,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              style: AppTextStyles.profileText.copyWith(
                color: widget.theme.mainColor,
              ),
              cursorColor: widget.theme.mainColor,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onSubmitted: (_) {
                widget.onChanged(controller.text);
              },
            )
          : Center(
              child: Text(
                controller.text,
                textAlign: TextAlign.center,
                style: AppTextStyles.profileText.copyWith(
                  color: widget.theme.mainColor,
                ),
              ),
            ),
    );
  }
}
