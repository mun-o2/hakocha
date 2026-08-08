import 'package:flutter/material.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_colors.dart';
import '../common/outlined_text.dart';
import '../../../constants/profile_theme.dart';

import 'package:hakocha/models/profile_data.dart';
import '../decorations/which_one_frame.dart';

//Which One?コーナー
class ProfileWhichOne extends StatelessWidget {
  final bool editable;
  final ProfileCardThemeColor theme;
  final ProfileData profile;
  const ProfileWhichOne({
    super.key,
    this.editable = true,
    required this.theme,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return (Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedText(
          text: "あなたはどっち派？",
          style: AppTextStyles.profileFormatSmall,
          outlineColor: AppColors.white,
          mainColor: theme.mainColor,
          strokeWidth: 2,
        ),

        // Which One?見出し
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 0),
          child: OutlinedText(
            text: "Which One?",
            style: AppTextStyles.profileTitle,
            outlineColor: theme.mainColor,
            mainColor: AppColors.white,
          ),
        ),
        const SizedBox(height: 5),
        //枠
        ProfileWhichOneFrame(
          width: 300,
          height: 220,
          theme: theme,
          child: ProfileWhichOneContents(
            theme: theme,
            editable: editable,
            profile: profile,
          ),
        ),
      ],
    ));
  }
}

//Which One?質問内容
class ProfileWhichOneContents extends StatefulWidget {
  final bool editable;
  final ProfileCardThemeColor theme;
  final ProfileData profile;
  const ProfileWhichOneContents({
    super.key,
    this.editable = true,
    required this.theme,
    required this.profile,
  });

  @override
  State<ProfileWhichOneContents> createState() =>
      _ProfileWhichOneContentsState();
}

class _ProfileWhichOneContentsState extends State<ProfileWhichOneContents> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileWhichOneSelector(
              prefix: "自分は【",
              leftLabel: "   犬   ",
              rightLabel: "   猫   ",
              suffix: "】派",
              theme: widget.theme,
              value: widget.profile.dogOrCat,
              editable: widget.editable,
              onChanged: (v) {
                setState(() {
                  widget.profile.dogOrCat = v;
                });
              },
            ),

            const SizedBox(height: 12),

            ProfileWhichOneSelector(
              prefix: "休日は【",
              leftLabel: "   インドア   ",
              rightLabel: "   アウトドア   ",
              suffix: "】派",
              theme: widget.theme,
              value: widget.profile.indoorOrOutdoor,
              editable: widget.editable,
              onChanged: (v) {
                setState(() {
                  widget.profile.indoorOrOutdoor = v;
                });
              },
            ),

            const SizedBox(height: 12),

            ProfileWhichOneSelector(
              prefix: "絶叫系は【",
              leftLabel: "   乗れる   ",
              rightLabel: "   乗れない   ",
              suffix: "】",
              theme: widget.theme,
              value: widget.profile.thrill,
              editable: widget.editable,
              onChanged: (v) {
                setState(() {
                  widget.profile.thrill = v;
                });
              },
            ),

            const SizedBox(height: 12),

            ProfileWhichOneSelector(
              prefix: "【",
              leftLabel: "   きのこの山   ",
              rightLabel: "   たけのこの里   ",
              suffix: "】派",
              theme: widget.theme,
              value: widget.profile.kinokoOrTakenoko,
              editable: widget.editable,
              onChanged: (v) {
                setState(() {
                  widget.profile.kinokoOrTakenoko = v;
                });
              },
            ),

            const SizedBox(height: 12),

            ProfileWhichOneSelector(
              prefix: "返信は【",
              leftLabel: "   すぐ返信する   ",
              rightLabel: "   溜めがち   ",
              suffix: "】",
              theme: widget.theme,
              value: widget.profile.reply,
              editable: widget.editable,
              onChanged: (v) {
                setState(() {
                  widget.profile.reply = v;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
              const Icon(
                Icons.circle_outlined,
                size: 22,
                color: AppColors.circleOutlined,
              ),
          ],
        ),
      ),
    );
  }
}
