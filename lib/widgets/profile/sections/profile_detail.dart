import 'package:flutter/material.dart';
import 'package:hakocha/models/profile_data.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_colors.dart';
import '../common/outlined_text.dart';
import '../inputs/profile_input_box.dart';
import '../decorations/white_square.dart';
import '../../profile/common/profile_container.dart';
import '../../../constants/profile_theme.dart';

//プロフィール詳細
class ProfileDetail extends StatelessWidget {
  final bool editable;
  final ProfileCardThemeColor theme;
  final ProfileData profile;

  const ProfileDetail({
    super.key,
    this.editable = true,
    required this.theme,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return (Stack(
      children: [
        Positioned(
          left: 20,
          bottom: 5,
          child: Column(
            children: [
              ProfileDetailItem(
                title: "出身地",
                boxLeft: 20,
                fieldValue: profile.birthplace,
                onChanged: (text) {
                  profile.birthplace = text;
                },
                editable: editable,
                theme: theme,
              ),
              const SizedBox(width: 20),

              ProfileDetailItem(
                title: "兄弟構成",
                boxLeft: 20,
                fieldValue: profile.brothers,
                onChanged: (text) {
                  profile.brothers = text;
                },
                editable: editable,
                theme: theme,
              ),
              const SizedBox(width: 20),

              ProfileDetailItem(
                title: "身長",
                boxLeft: 20,
                fieldValue: profile.height,
                onChanged: (text) {
                  profile.height = text;
                },
                editable: editable,
                theme: theme,
              ),
              const SizedBox(width: 20),

              ProfileDetailItem(
                title: "靴のサイズ",
                boxLeft: 20,
                fieldValue: profile.shoeSize,
                onChanged: (text) {
                  profile.shoeSize = text;
                },
                editable: editable,
                theme: theme,
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    ));
  }
}

//プロフィール詳細のフォーマット
class ProfileDetailItem extends StatelessWidget {
  final String title;
  final double boxLeft;
  final String fieldValue;
  final ValueChanged<String> onChanged;
  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileDetailItem({
    super.key,
    required this.title,
    required this.boxLeft,
    required this.fieldValue,
    required this.editable,
    required this.theme,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 53,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: boxLeft,
            top: 20,
            child: ProfileContainer(
              width: 100,
              height: 25,

              background: const ProfileWhiteSquare(),

              child: ProfileInputBox(
                value: fieldValue,
                editable: editable,
                theme: theme,
                onChanged: onChanged,
              ),
            ),
          ),

          Positioned(
            left: 0,
            top: 0,
            child: OutlinedText(
              text: title,
              style: AppTextStyles.profileFormatSmall,
              mainColor: theme.mainColor,
              outlineColor: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
