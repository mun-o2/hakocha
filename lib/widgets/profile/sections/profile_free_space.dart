import 'package:flutter/material.dart';
import 'package:hakocha/models/profile_data.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_colors.dart';
import '../common/outlined_text.dart';
import '../decorations/white_square.dart';
import '../../profile/common/profile_container.dart';
import '../../../constants/profile_theme.dart';
import '../inputs/profile_free_space_input.dart';

//Free Space
class ProfileFreeSpace extends StatelessWidget {
  final ProfileData profile;
  final bool editable;
  final ProfileCardThemeColor theme;
  const ProfileFreeSpace({
    super.key,
    required this.profile,
    required this.editable,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return (SizedBox(
      width: 300,
      height: 180,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Free Space
          Positioned(
            left: 0,
            top: 0,
            child: OutlinedText(
              text: "Free Space",
              style: AppTextStyles.profileTitle,
              outlineColor: theme.mainColor,
              mainColor: AppColors.white,
            ),
          ),
          Positioned(
            left: 160,
            top: 40,
            child: Align(
              alignment: Alignment.centerRight,
              child: OutlinedText(
                text: "ここは自由に記入してね",
                style: AppTextStyles.profileFormatSmall,
                outlineColor: AppColors.white,
                mainColor: theme.mainColor,
                strokeWidth: 2,
              ),
            ),
          ),

          // 入力欄
          Positioned(
            left: 0,
            top: 65,
            child: ProfileContainer(
              width: 310,
              height: 130,

              background: const ProfileWhiteSquare(),

              child: Padding(
                padding: const EdgeInsets.all(5),
                child: ProfileFreeSpaceInput(
                  value: profile.freeSpace,
                  editable: editable,
                  theme: theme,
                  onChanged: (text) {
                    profile.freeSpace = text;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
