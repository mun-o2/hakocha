import 'package:flutter/material.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/profile_theme.dart';

class ProfileHeartInput extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final bool editable;
  final ProfileCardThemeColor theme;
  final double height;
  final double width;

  const ProfileHeartInput({
    super.key,
    required this.value,
    required this.onChanged,
    required this.editable,
    required this.theme,
    required this.height,
    required this.width,
  });

  @override
  State<ProfileHeartInput> createState() => _ProfileHeartInputState();
}

class _ProfileHeartInputState extends State<ProfileHeartInput> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant ProfileHeartInput oldWidget) {
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
      width: widget.width,
      height: widget.height,
      child: Center(
        child: widget.editable
            ? TextField(
                controller: controller,
                maxLines: 2,
                minLines: 1,
                textInputAction: TextInputAction.done,
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
            : Text(
                controller.text,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: AppTextStyles.profileText.copyWith(
                  color: widget.theme.mainColor,
                  height: 1.0,
                ),
              ),
      ),
    );
  }
}
