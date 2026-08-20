import 'package:flutter/material.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_colors.dart';
import '../common/outlined_text.dart';
import '../../../constants/profile_theme.dart';

import 'package:hakocha/models/profile_data.dart';
import '../decorations/which_one_frame.dart';
import '../inputs/profile_whice_one_selector.dart';

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
    return Positioned(
      top: 175,
      left: 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OutlinedText(
            text: "あなたはどっち派？",
            style: AppTextStyles.profileFormatSmall,
            outlineColor: AppColors.white,
            mainColor: theme.mainColor,
            strokeWidth: 2,
          ),

          // Which One?見出し
          OutlinedText(
            text: "Which One?",
            style: AppTextStyles.profileTitle,
            outlineColor: theme.mainColor,
            mainColor: AppColors.white,
          ),

          const SizedBox(height: 2),
          //枠
          ProfileWhichOneFrame(
            width: 270,
            height: 211,
            theme: theme,
            child: ProfileWhichOneContents(
              theme: theme,
              editable: editable,
              profile: profile,
            ),
          ),
        ],
      ),
    );
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
    return Positioned(
      top: 170,
      left: 20,
      right: 0,
      child: SizedBox(
        width: 230,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
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

              const SizedBox(height: 10),

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

              const SizedBox(height: 10),

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

              const SizedBox(height: 10),

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

              const SizedBox(height: 10),

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
      ),
    );
  }
}
