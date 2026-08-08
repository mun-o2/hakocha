import 'package:flutter/material.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/profile_theme.dart';

class ProfileFreeSpaceInput extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileFreeSpaceInput({
    super.key,
    required this.value,
    required this.onChanged,
    required this.editable,
    required this.theme,
  });

  @override
  State<ProfileFreeSpaceInput> createState() => _ProfileFreeSpaceInputState();
}

class _ProfileFreeSpaceInputState extends State<ProfileFreeSpaceInput> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant ProfileFreeSpaceInput oldWidget) {
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
    return widget.editable
        ? TextField(
            controller: controller,

            expands: true,
            maxLines: null,
            minLines: null,

            textAlign: TextAlign.left,
            textAlignVertical: TextAlignVertical.top,

            style: AppTextStyles.profileText.copyWith(
              color: widget.theme.mainColor,
            ),
            cursorColor: widget.theme.mainColor,

            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(14),
            ),

            onChanged: widget.onChanged,
          )
        : Padding(
            padding: const EdgeInsets.all(14),
            child: SingleChildScrollView(
              child: Text(
                controller.text,
                style: AppTextStyles.profileText.copyWith(
                  color: widget.theme.mainColor,
                ),
              ),
            ),
          );
  }
}
