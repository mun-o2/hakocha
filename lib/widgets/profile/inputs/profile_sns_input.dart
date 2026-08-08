import 'package:flutter/material.dart';
import '../../../constants/profile_theme.dart';
import '../../../constants/app_text_styles.dart';

//SNS
class ProfileSnsInput extends StatefulWidget {
  final double? width;
  final String value;
  final ValueChanged<String> onChanged;
  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileSnsInput({
    super.key,
    this.width,
    required this.value,
    required this.onChanged,
    required this.editable,
    required this.theme,
  });

  @override
  State<ProfileSnsInput> createState() => _ProfileSnsInputState();
}

class _ProfileSnsInputState extends State<ProfileSnsInput> {
  late TextEditingController controller;
  bool editing = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant ProfileSnsInput oldWidget) {
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
    if (!editing) {
      return GestureDetector(
        onTap: widget.editable
            ? () {
                setState(() {
                  editing = true;
                });
              }
            : null,
        child: SizedBox(
          width: widget.width,
          child: Text(
            controller.text,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.visible,
            style: AppTextStyles.profileText.copyWith(
              color: widget.theme.mainColor,
            ),
          ),
        ),
      );
    }

    Widget field = TextField(
      controller: controller,
      autofocus: true,
      style: AppTextStyles.profileText.copyWith(color: widget.theme.mainColor),
      cursorColor: widget.theme.mainColor,
      decoration: const InputDecoration(
        isDense: true,
        border: InputBorder.none,
      ),
      onSubmitted: (_) {
        widget.onChanged(controller.text);
        setState(() => editing = false);
      },
    );

    return widget.width == null
        ? field
        : SizedBox(width: widget.width, child: field);
  }
}
