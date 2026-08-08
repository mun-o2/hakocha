import 'package:flutter/material.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/profile_theme.dart';

class ProfileEllipseInput extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;

  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileEllipseInput({
    super.key,
    required this.value,
    required this.onChanged,
    required this.editable,
    required this.theme,
  });

  @override
  State<ProfileEllipseInput> createState() => _ProfileEllipseInputState();
}

class _ProfileEllipseInputState extends State<ProfileEllipseInput> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant ProfileEllipseInput oldWidget) {
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
    return Center(
      child: SizedBox(
        width: 120,
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
            : Text(
                controller.text,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: AppTextStyles.profileText.copyWith(
                  color: widget.theme.mainColor,
                ),
              ),
      ),
    );
  }
}
