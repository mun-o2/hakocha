import 'package:flutter/material.dart';
import 'package:hakocha/models/profile_data.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_colors.dart';
import '../common/outlined_text.dart';
import '../../../constants/profile_theme.dart';

//YES・NO質問のフォーマット
class ProfileYesNoSelector extends StatelessWidget {
  final String question;
  final YesNoAnswer value;
  final ValueChanged<YesNoAnswer> onChanged;
  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileYesNoSelector({
    super.key,
    required this.question,
    required this.value,
    required this.onChanged,
    required this.editable,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          child: Align(
            alignment: Alignment.centerRight,
            child: OutlinedText(
              text: question,
              style: AppTextStyles.profileFormatSmall,
              outlineColor: theme.mainColor,
              mainColor: AppColors.white,
              strokeWidth: 2.5,
            ),
          ),
        ),

        const SizedBox(width: 3),

        YesNoButton(
          label: "YES",
          value: value,
          myValue: YesNoAnswer.yes,
          onChanged: onChanged,
          editable: editable,
          theme: theme,
        ),

        const SizedBox(width: 8),

        YesNoButton(
          label: "NO",
          value: value,
          myValue: YesNoAnswer.no,
          onChanged: onChanged,
          editable: editable,
          theme: theme,
        ),
      ],
    );
  }
}

//二択のボタンフォーマット
class YesNoButton extends StatelessWidget {
  final String label;
  final YesNoAnswer value;
  final YesNoAnswer myValue;
  final ValueChanged<YesNoAnswer> onChanged;
  final bool editable;
  final ProfileCardThemeColor theme;

  const YesNoButton({
    super.key,
    required this.label,
    required this.value,
    required this.myValue,
    required this.onChanged,
    required this.editable,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == myValue;

    return SizedBox(
      width: 25,
      height: 20,
      child: InkWell(
        onTap: editable
            ? () {
                if (selected) {
                  onChanged(YesNoAnswer.unknown);
                } else {
                  onChanged(myValue);
                }
              }
            : null,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            OutlinedText(
              text: label,
              style: AppTextStyles.profileFormatSmall,
              outlineColor: myValue == YesNoAnswer.yes
                  ? theme.mainColor
                  : AppColors.purple4,
              mainColor: AppColors.white,
              strokeWidth: 2.5,
            ),
            selected
                ? const Icon(
                    Icons.circle_outlined,
                    size: 22,
                    color: AppColors.circleOutlined,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
