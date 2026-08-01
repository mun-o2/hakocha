import 'package:flutter/material.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_colors.dart';

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

class ProfileInputHeart extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const ProfileInputHeart({
    super.key,
    required this.value,
    required this.onChanged,
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

class ProfileEllipseInput extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final double? width;

  const ProfileEllipseInput({
    super.key,
    required this.value,
    required this.onChanged,
    this.width,
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
    Widget field = TextField(
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
    );

    return widget.width == null
        ? field
        : SizedBox(width: widget.width, child: field);
  }
}

class ProfileFreeSpaceInput extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final double width;
  final double height;

  const ProfileFreeSpaceInput({
    super.key,
    required this.value,
    required this.onChanged,
    required this.width,
    required this.height,
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
      child: TextField(
        controller: controller,

        expands: true,
        maxLines: null,
        minLines: null,

        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.top,

        style: AppTextStyles.profileText,
        cursorColor: AppColors.pink4,

        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14),
        ),

        onChanged: widget.onChanged,
      ),
    );
  }
}
