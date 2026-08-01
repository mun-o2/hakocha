import 'package:flutter/material.dart';

import 'package:hakocha/dummy/dummy_profile2.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_colors.dart';
import '../constants/profile_theme.dart';
import '../dummy/dummy_profile.dart';

import 'outlined_text.dart';
import 'profile_card_parts.dart';
import 'profile_edit_parts.dart';
import '../constants/profile_theme.dart';

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
        width: 400,
        height: 740,
        child: ProfileCardBody(
          isLeft: true,
          theme: widget.theme,
          child: Stack(
            children: [
              // 白い四角
              Positioned(
                left: 27,
                top: 43,
                child: const ProfileWhiteSquare(width: 310, height: 155),
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
              ProfileCardDetail(
                editable: widget.editable,
                theme: widget.theme,
                profile: profileData,
              ),
              // Love Talk大ハート
              Positioned(
                left: 110,
                bottom: -20,
                child: LoveTalkHeart(isPink: true, theme: widget.theme),
              ),
              ProfileLoveTalk(
                editable: widget.editable,
                theme: widget.theme,
                profile: profileData,
              ),

              // Love Talk小ハート
              Positioned(
                right: 0,
                bottom: 0,
                child: LoveTalkHeart(isPink: false, theme: widget.theme),
              ),
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
              Positioned(
                right: -8,
                bottom: 30,
                child: ProfileInputHeart(
                  value: profileData.idealType,
                  editable: widget.editable,
                  theme: widget.theme,
                  onChanged: (text) {
                    profileData.idealType = text;
                  },
                ),
              ),

              // 文字入力部分の追加必要
            ],
          ),
        ),
      ),
    );
  }
}
