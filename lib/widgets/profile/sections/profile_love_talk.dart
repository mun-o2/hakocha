import 'package:flutter/material.dart';
import 'package:hakocha/models/profile_data.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_colors.dart';
import '../common/outlined_text.dart';
import '../../../constants/profile_theme.dart';
import '../inputs/profile_yes_no.dart';
import '../decorations/heart_background.dart';
import '../inputs/profile_heart_input.dart';

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
      left: 155,
      right: 10,
      bottom: 105,
      child: SizedBox(
        width: 250,
        height: 300,
        child: Stack(
          children: [
            // 大きなハート
            Positioned(
              left: -45,
              bottom: -120,
              child: LoveTalkHeart(isPink: true, theme: widget.theme),
            ),

            // LoveTalk
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedText(
                    text: "LoveTalk",
                    style: AppTextStyles.profileTitle,
                    outlineColor: widget.theme.mainColor,
                    mainColor: AppColors.white,
                  ),

                  const SizedBox(height: 12),

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

            // 小さなハート
            Positioned(
              right: 0,
              bottom: 0,
              child: LoveTalkHeart(isPink: false, theme: widget.theme),
            ),

            // 理想のタイプ
            Positioned(
              right: 0,
              bottom: 80,
              child: OutlinedText(
                text: "理想のタイプは？",
                style: AppTextStyles.profileFormatSmall,
                outlineColor: AppColors.white,
                strokeWidth: 2.5,
                mainColor: AppColors.purple4,
              ),
            ),

            // 理想のタイプ入力
            Positioned(
              right: -8,
              bottom: 30,
              child: ProfileInputHeart(
                value: widget.profile.idealType,
                editable: widget.editable,
                theme: widget.theme,
                onChanged: (text) {
                  widget.profile.idealType = text;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
