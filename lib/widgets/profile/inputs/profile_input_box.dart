import 'package:flutter/material.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/profile_theme.dart';

//白い四角い枠の入力スペース
class ProfileInputBox extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileInputBox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.editable,
    required this.theme,
  });

  @override
  State<ProfileInputBox> createState() => _ProfileInputBoxState();
}

class _ProfileInputBoxState extends State<ProfileInputBox> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant ProfileInputBox oldWidget) {
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
    if (widget.editable) {
      return TextField(
        controller: controller,
        textAlign: TextAlign.center,
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
      );
    }

    return Center(
      child: Text(
        controller.text,
        textAlign: TextAlign.center,
        style: AppTextStyles.profileText.copyWith(
          color: widget.theme.mainColor,
        ),
      ),
    );
  }
}
