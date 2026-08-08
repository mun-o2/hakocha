import 'package:flutter/material.dart';
import 'package:hakocha/dummy/dummy_profile2.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_colors.dart';
import 'profile/common/outlined_text.dart';
import 'profile/common/profile_card_base.dart';
import '../constants/profile_theme.dart';

import 'profile/decorations/white_square.dart';
import '../widgets/profile/common/profile_container.dart';

import '../widgets/profile/sections/profile_main_description.dart';
import '../widgets/profile/sections/profile_detail.dart';
import '../widgets/profile/sections/profile_header.dart';
import '../widgets/profile/sections/profile_love_talk.dart';

//ダミーデータの読み込み
import '../dummy/dummy_profile.dart';
import '../dummy/dummy_profile2.dart';
import '../models/profile_data.dart';

class ProfileCardLeft extends StatefulWidget {
  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileCardLeft({super.key, this.editable = true, required this.theme});

  @override
  State<ProfileCardLeft> createState() => _ProfileCardLeftState();
}

class _ProfileCardLeftState extends State<ProfileCardLeft> {
  late ProfileData profileData;

  @override
  Widget build(BuildContext context) {
    profileData = widget.theme == pinkProfileCardTheme
        ? dummyProfile
        : dummyProfile2;

    return Center(
      child: SizedBox(
        width: 360,
        height: 666,
        child: ProfileCardBody(
          isLeft: true,
          theme: widget.theme,
          child: Stack(
            children: [
              // 白い四角
              Positioned(
                left: 27,
                top: 43,
                child: ProfileContainer(
                  width: 270,
                  height: 134,
                  background: const ProfileWhiteSquare(),
                  child: const SizedBox(),
                ),
              ),

              // My Profile見出し
              Padding(
                padding: const EdgeInsets.only(top: 22, left: 25),
                child: OutlinedText(
                  text: "My Profile",
                  style: AppTextStyles.profileTitle,
                  outlineColor: widget.theme.mainColor,
                  mainColor: AppColors.white,
                ),
              ),

              // 似顔絵・SNS
              ProfileHeader(
                profile: profileData,
                editable: widget.editable,
                theme: widget.theme,
              ),
              // メインプロフィール文
              ProfileMainDescription(
                profile: profileData,
                editable: widget.editable,
                theme: widget.theme,
              ),
              // 左下詳細プロフィール
              ProfileDetail(
                editable: widget.editable,
                theme: widget.theme,
                profile: profileData,
              ),
              // Love Talk
              ProfileLoveTalk(
                editable: widget.editable,
                theme: widget.theme,
                profile: profileData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
