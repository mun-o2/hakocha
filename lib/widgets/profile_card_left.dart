import 'package:flutter/material.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_colors.dart';
import 'outlined_text.dart';
import 'profile_card_parts.dart';
import 'profile_edit_parts.dart';

//ダミーデータの読み込み
import '../dummy/dummy_profile.dart';

class ProfileCardLeft extends StatefulWidget {
  const ProfileCardLeft({super.key});

  @override
  State<ProfileCardLeft> createState() => _ProfileCardLeftState();
}

class _ProfileCardLeftState extends State<ProfileCardLeft> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 740,
        child: ProfileCardBody(
          isLeft: true,
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
                  outlineColor: AppColors.pink4,
                ),
              ),

              // 似顔絵・SNS
              ProfileHeader(
                instagramId: dummyProfile.instagramId,
                xId: dummyProfile.xId,
              ),
              // メインプロフィール文
              const ProfileMainDescription(),
              // 左下詳細プロフィール
              const ProfileCardDetail(),
              // Love Talk大ハート
              Positioned(
                left: 110,
                bottom: -20,
                child: const LoveTalkHeart(isPink: true),
              ),
              const ProfileLoveTalk(),

              // Love Talk小ハート
              Positioned(
                right: 0,
                bottom: 0,
                child: const LoveTalkHeart(isPink: false),
              ),
              Positioned(
                right: 0,
                bottom: 80,
                child: OutlinedText(
                  text: "理想のタイプは？",
                  style: AppTextStyles.profileFormatText3,
                  outlineColor: AppColors.white,
                  strokeWidth: 2.5,
                ),
              ),
              Positioned(
                right: -8,
                bottom: 30,
                child: ProfileInputHeart(
                  value: dummyProfile.idealType,
                  onChanged: (text) {
                    dummyProfile.idealType = text;
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
