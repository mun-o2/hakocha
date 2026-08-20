import 'package:flutter/material.dart';
import 'package:hakocha/models/profile_data.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/profile_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Which One?質問フォーマット
class ProfileWhichOneSelector extends StatelessWidget {
  final String prefix;
  final String leftLabel;
  final String rightLabel;
  final String suffix;
  final ProfileCardThemeColor theme;

  final WhichOneAnswer value;
  final ValueChanged<WhichOneAnswer> onChanged;

  final bool editable;
  const ProfileWhichOneSelector({
    super.key,
    required this.prefix,
    required this.leftLabel,
    required this.rightLabel,
    required this.suffix,
    required this.value,
    required this.onChanged,
    required this.editable,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          prefix,
          style: AppTextStyles.profileFormatSmall.copyWith(
            color: theme.mainColor,
          ),
        ),

        WhichOneChoiceButton(
          label: leftLabel,
          value: value,
          myValue: WhichOneAnswer.left,
          editable: editable,
          theme: theme,
          onChanged: onChanged,
        ),

        SizedBox(
          width: 18,
          child: WhichOneChoiceButton(
            label: "・",
            value: value,
            myValue: WhichOneAnswer.center,
            editable: editable,
            theme: theme,
            onChanged: onChanged,
          ),
        ),

        WhichOneChoiceButton(
          label: rightLabel,
          value: value,
          myValue: WhichOneAnswer.right,
          editable: editable,
          theme: theme,
          onChanged: onChanged,
        ),

        Text(
          suffix,
          style: AppTextStyles.profileFormatSmall.copyWith(
            color: theme.mainColor,
          ),
        ),
      ],
    );
  }
}

//Which One?の選択ボタンフォーマット
class WhichOneChoiceButton extends StatelessWidget {
  final String label;
  final WhichOneAnswer value;
  final WhichOneAnswer myValue;
  final bool editable;
  final ProfileCardThemeColor theme;
  final ValueChanged<WhichOneAnswer> onChanged;

  const WhichOneChoiceButton({
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
      height: 26,
      child: InkWell(
        onTap: editable
            ? () {
                if (selected) {
                  onChanged(WhichOneAnswer.unknown);
                } else {
                  onChanged(myValue);
                }
              }
            : null,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              label,
              style: AppTextStyles.profileFormatSmall.copyWith(
                color: theme.mainColor,
              ),
            ),

            if (selected)
              SvgPicture.asset(
                'lib/assets/images/profile/doodle_circle.svg',
                width: 22,
                height: 22,
              ),
          ],
        ),
      ),
    );
  }
}
