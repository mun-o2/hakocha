import 'package:flutter/material.dart';
import 'package:hakocha/models/profile_data.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_colors.dart';
import '../common/outlined_text.dart';
import '../decorations/white_ellipse.dart';
import '../../profile/common/profile_container.dart';
import '../inputs/profile_ellipse_input.dart';
import '../../../constants/profile_theme.dart';

//もしもコーナー
class ProfileIfCorner extends StatelessWidget {
  final ProfileData profile;
  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileIfCorner({
    super.key,
    required this.profile,
    required this.editable,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
        Row(
          children: [
            // if...見出し
            Padding(
              padding: const EdgeInsets.only(top: 22, left: 25),
              child: OutlinedText(
                text: "if...",
                style: AppTextStyles.profileTitle,
                outlineColor: theme.mainColor,
                mainColor: AppColors.white,
              ),
            ),
            const SizedBox(width: 20),

            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: OutlinedText(
                text: "もしもコーナー",
                style: AppTextStyles.profileFormatSmall,
                outlineColor: AppColors.white,
                mainColor: theme.mainColor,
                strokeWidth: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        Row(
          children: [
            const SizedBox(width: 30),

            ProfileContainer(
              width: 145,
              height: 110,

              background: const WhiteEllipse(),

              title: Positioned(
                left: 15,
                top: 5,
                child: OutlinedText(
                  text: "魔法がつかえたら…",
                  style: AppTextStyles.profileFormatSmall,
                  outlineColor: AppColors.white,
                  mainColor: theme.mainColor,
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Center(
                  child: ProfileEllipseInput(
                    value: profile.ifMagicWish,
                    editable: editable,
                    theme: theme,
                    onChanged: (text) {
                      profile.ifMagicWish = text;
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(width: 30),

            ProfileContainer(
              width: 145,
              height: 110,

              background: const WhiteEllipse(),

              title: Positioned(
                left: 15,
                top: 5,
                child: OutlinedText(
                  text: "生まれ変わるなら…",
                  style: AppTextStyles.profileFormatSmall,
                  outlineColor: AppColors.white,
                  mainColor: theme.mainColor,
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Center(
                  child: ProfileEllipseInput(
                    value: profile.ifNextLife,
                    editable: editable,
                    theme: theme,
                    onChanged: (text) {
                      profile.ifNextLife = text;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
