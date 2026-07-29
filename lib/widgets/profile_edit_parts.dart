import 'package:flutter/material.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_colors.dart';

//白い枠以外の入力スペース
//SNS
class ProfileEditableText extends StatefulWidget {
  final double? width;
  final String value;
  final ValueChanged<String> onChanged;

  const ProfileEditableText({
    super.key,
    this.width,
    required this.value,
    required this.onChanged,
  });

  @override
  State<ProfileEditableText> createState() => _ProfileEditableTextState();
}

class _ProfileEditableTextState extends State<ProfileEditableText> {
  late TextEditingController controller;
  bool editing = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  //データの更新
  @override
  void didUpdateWidget(covariant ProfileEditableText oldWidget) {
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
        onTap: () {
          setState(() {
            editing = true;
          });
        },
        child: SizedBox(
          width: widget.width,
          child: Text(
            controller.text,
            style: AppTextStyles.profileText,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }

    Widget field = TextField(
      controller: controller,
      autofocus: true,
      style: AppTextStyles.profileText,
      cursorColor: AppColors.pink4,
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

//ハート形の入力スペース
class ProfileHeartInput extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const ProfileHeartInput({
    super.key,
    required this.value,
    required this.onChanged,
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
      width: 125,
      child: TextField(
        controller: controller,
        maxLines: 2,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: AppTextStyles.profileText,
        cursorColor: AppColors.pink4,
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        onSubmitted: (_) {
          widget.onChanged(controller.text);
        },
      ),
    );
  }
}
