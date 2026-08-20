import 'package:flutter/material.dart';
import 'package:hakocha/models/profile_data.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_colors.dart';
import '../common/outlined_text.dart';
import '../../../constants/profile_theme.dart';
import '../inputs/profile_yes_no.dart';
import '../decorations/heart_background.dart';
import '../inputs/profile_heart_input.dart';
import '../common/profile_container.dart';

// LoveTalk
class ProfileLoveTalk extends StatefulWidget {
  final bool editable;
  final ProfileCardThemeColor theme;
  final ProfileData profile;

  const ProfileLoveTalk({
    super.key,
    this.editable = true,
    required this.theme,
    required this.profile,
  });

  @override
  State<ProfileLoveTalk> createState() => _ProfileLoveTalkState();
}

class _ProfileLoveTalkState extends State<ProfileLoveTalk> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 420,
      left: 126,
      right: 0,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          //大きいハート
          ProfileContainer(
            width: 211,
            height: 233,
            background: LoveTalkHeart(isPurple: false, theme: widget.theme),

            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // LoveTalk
                  OutlinedText(
                    text: "LoveTalk",
                    style: AppTextStyles.profileTitle,
                    outlineColor: widget.theme.mainColor,
                    mainColor: AppColors.white,
                  ),

                  const SizedBox(height: 3),

                  ProfileYesNoSelector(
                    question: "告白したことある？",
                    value: widget.profile.confessed,
                    editable: widget.editable,
                    theme: widget.theme,
                    onChanged: (v) {
                      setState(() {
                        widget.profile.confessed = v;
                      });
                    },
                  ),

                  const SizedBox(height: 8),

                  ProfileYesNoSelector(
                    question: "告白されたことある？",
                    value: widget.profile.beenConfessed,
                    editable: widget.editable,
                    theme: widget.theme,
                    onChanged: (v) {
                      setState(() {
                        widget.profile.beenConfessed = v;
                      });
                    },
                  ),

                  const SizedBox(height: 8),

                  ProfileYesNoSelector(
                    question: "今好きな人はいる？",
                    value: widget.profile.hasCrush,
                    editable: widget.editable,
                    theme: widget.theme,
                    onChanged: (v) {
                      setState(() {
                        widget.profile.hasCrush = v;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            left: 92,
            top: 138,
            child: ProfileContainer(
              width: 107,
              height: 97,
              background: LoveTalkHeart(isPurple: true, theme: widget.theme),

              title: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: OutlinedText(
                    text: "理想のタイプは？",
                    style: AppTextStyles.profileFormatSmall,
                    outlineColor: AppColors.white,
                    mainColor: AppColors.purple4,
                  ),
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 15),
                child: ProfileHeartInput(
                  value: widget.profile.idealType,
                  editable: widget.editable,
                  theme: widget.theme,
                  height: 60,
                  width: 102,
                  onChanged: (text) {
                    widget.profile.idealType = text;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
