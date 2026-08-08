import 'package:flutter/material.dart';
import 'package:hakocha/models/profile_data.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_colors.dart';
import '../common/outlined_text.dart';
import '../../../constants/profile_theme.dart';

//instagramとXのアイコン
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:iconify_flutter/icons/bxl.dart';

import '../inputs/profile_sns_input.dart';
import '../../image_picker_sheet.dart';

//似顔絵・SNS部分
class ProfileHeader extends StatelessWidget {
  final ProfileData profile;
  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileHeader({
    super.key,
    required this.profile,
    required this.editable,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 45,
      top: 65,
      child: SizedBox(
        width: 270,
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // にがおえ
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: editable
                  ? () {
                      showImagePickerSheet(context);
                    }
                  : null,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 88,
                    height: 97,
                    decoration: BoxDecoration(
                      color: theme.backgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: theme.backgroundColor.withValues(alpha: 0.8),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: -10,
                    child: OutlinedText(
                      text: "にがおえ",
                      style: AppTextStyles.profileFormatLarge,
                      outlineColor: AppColors.white,
                      mainColor: theme.mainColor,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 55),

            // SNS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: OutlinedText(
                      text: "SNS",
                      style: AppTextStyles.profileSNSLabel,
                      outlineColor: theme.mainColor,
                      mainColor: AppColors.white,
                      strokeWidth: 2.5,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Iconify(
                        AntDesign.instagram_outlined,
                        color: theme.mainColor,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: editable
                            ? ProfileSnsInput(
                                value: profile.instagramId,
                                editable: editable,
                                theme: theme,
                                onChanged: (text) {
                                  profile.instagramId = text;
                                },
                              )
                            : Text(
                                profile.instagramId,
                                style: AppTextStyles.profileText.copyWith(
                                  color: theme.mainColor,
                                ),
                              ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Iconify(Bxl.twitter, color: theme.mainColor, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: editable
                            ? ProfileSnsInput(
                                value: profile.xId,
                                editable: editable,
                                theme: theme,
                                onChanged: (text) {
                                  profile.xId = text;
                                },
                              )
                            : Text(
                                profile.xId,
                                style: AppTextStyles.profileText.copyWith(
                                  color: theme.mainColor,
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
