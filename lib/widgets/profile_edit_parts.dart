import 'package:flutter/material.dart';
import 'package:hakocha/constants/profile_theme.dart';
import '../constants/app_text_styles.dart';

//SNS
class ProfileEditableText extends StatefulWidget {
  final double? width;
  final String value;
  final ValueChanged<String> onChanged;
  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileEditableText({
    super.key,
    this.width,
    required this.value,
    required this.onChanged,
    required this.editable,
    required this.theme,
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
      style: AppTextStyles.profileText,
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

//Love Talk右下
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

//もしもコーナー用白い楕円
class ProfileEllipseInput extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final double? width;
  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileEllipseInput({
    super.key,
    required this.value,
    required this.onChanged,
    this.width,
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
    Widget child = widget.editable
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
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: AppTextStyles.profileText.copyWith(
                color: widget.theme.mainColor,
              ),
            ),
          );

    return widget.width == null
        ? child
        : SizedBox(width: widget.width, child: child);
  }
}

class ProfileFreeSpaceInput extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final double width;
  final double height;
  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileFreeSpaceInput({
    super.key,
    required this.value,
    required this.onChanged,
    required this.width,
    required this.height,
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
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: widget.editable
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
            ),
    );
  }
}
