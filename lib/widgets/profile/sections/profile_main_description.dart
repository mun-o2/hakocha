import 'package:flutter/material.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_colors.dart';
import '../common/outlined_text.dart';
import '../../../constants/profile_theme.dart';
import '../inputs/profile_input_box.dart';
import '../decorations/white_square.dart';
import '../../profile/common/profile_container.dart';

import 'package:hakocha/models/profile_data.dart';

//基本プロフィール本文
class ProfileMainDescription extends StatelessWidget {
  final bool editable;
  final ProfileData profile;
  final ProfileCardThemeColor theme;
  const ProfileMainDescription({
    super.key,
    this.editable = true,
    required this.profile,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return (Stack(
      children: [
        Positioned(
          left: 20,
          top: 210,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //1行目
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedText(
                    text: "わたしの名前は",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 20),

                  ProfileContainer(
                    width: 100,
                    height: 25,
                    background: const ProfileWhiteSquare(),
                    child: ProfileInputBox(
                      value: profile.name,
                      editable: editable,
                      theme: theme,
                      onChanged: (text) {
                        profile.mbti = text;
                      },
                    ),
                  ),

                  const SizedBox(width: 20),

                  OutlinedText(
                    text: "で、",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),
                ],
              ),

              const SizedBox(height: 11),

              //2行目
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileContainer(
                    width: 80,
                    height: 25,
                    background: const ProfileWhiteSquare(),
                    child: ProfileInputBox(
                      value: profile.birthYear,
                      editable: editable,
                      theme: theme,
                      onChanged: (text) {
                        profile.mbti = text;
                      },
                    ),
                  ),

                  const SizedBox(width: 4),

                  OutlinedText(
                    text: "年",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 4),
                  ProfileContainer(
                    width: 50,
                    height: 25,
                    background: const ProfileWhiteSquare(),
                    child: ProfileInputBox(
                      value: profile.birthMonth,
                      editable: editable,
                      theme: theme,
                      onChanged: (text) {
                        profile.mbti = text;
                      },
                    ),
                  ),
                  OutlinedText(
                    text: "月",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 4),
                  ProfileContainer(
                    width: 50,
                    height: 25,
                    background: const ProfileWhiteSquare(),
                    child: ProfileInputBox(
                      value: profile.birthDay,
                      editable: editable,
                      theme: theme,
                      onChanged: (text) {
                        profile.mbti = text;
                      },
                    ),
                  ),

                  OutlinedText(
                    text: "日生まれの",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),
                ],
              ),

              const SizedBox(height: 11),

              //3行目
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileContainer(
                    width: 70,
                    height: 25,
                    background: const ProfileWhiteSquare(),
                    child: ProfileInputBox(
                      value: profile.zodiacSign,
                      editable: editable,
                      theme: theme,
                      onChanged: (text) {
                        profile.mbti = text;
                      },
                    ),
                  ),
                  const SizedBox(width: 4),

                  OutlinedText(
                    text: "座だよ！",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 11),

                  OutlinedText(
                    text: "血液型は",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 4),
                  ProfileContainer(
                    width: 50,
                    height: 25,
                    background: const ProfileWhiteSquare(),
                    child: ProfileInputBox(
                      value: profile.bloodType,
                      editable: editable,
                      theme: theme,
                      onChanged: (text) {
                        profile.mbti = text;
                      },
                    ),
                  ),
                  const SizedBox(width: 4),

                  OutlinedText(
                    text: "型！",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),
                ],
              ),

              const SizedBox(height: 11),

              //4行目
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedText(
                    text: "MBTIは",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 4),

                  ProfileContainer(
                    width: 70,
                    height: 25,
                    background: const ProfileWhiteSquare(),
                    child: ProfileInputBox(
                      value: profile.mbti,
                      editable: editable,
                      theme: theme,
                      onChanged: (text) {
                        profile.mbti = text;
                      },
                    ),
                  ),

                  const SizedBox(width: 4),

                  OutlinedText(
                    text: "だよ！",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),
                ],
              ),

              const SizedBox(height: 11),

              //5行目
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedText(
                    text: "みんなからは",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 4),

                  ProfileContainer(
                    width: 80,
                    height: 25,
                    background: const ProfileWhiteSquare(),
                    child: ProfileInputBox(
                      value: profile.nickname,
                      editable: editable,
                      theme: theme,
                      onChanged: (text) {
                        profile.mbti = text;
                      },
                    ),
                  ),

                  const SizedBox(width: 4),

                  OutlinedText(
                    text: "って呼ばれてて、",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),
                ],
              ),

              const SizedBox(height: 11),

              //6行目
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedText(
                    text: "自分では",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 4),

                  ProfileContainer(
                    width: 150,
                    height: 25,
                    background: const ProfileWhiteSquare(),
                    child: ProfileInputBox(
                      value: profile.personality,
                      editable: editable,
                      theme: theme,
                      onChanged: (text) {
                        profile.mbti = text;
                      },
                    ),
                  ),

                  const SizedBox(width: 4),

                  OutlinedText(
                    text: "な性格だと",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),
                ],
              ),

              const SizedBox(height: 11),

              //7行目
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedText(
                    text: "思う！",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 11),

                  OutlinedText(
                    text: "休みの日は",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 8),

                  ProfileContainer(
                    width: 150,
                    height: 25,
                    background: const ProfileWhiteSquare(),
                    child: ProfileInputBox(
                      value: profile.holidayLife,
                      editable: editable,
                      theme: theme,
                      onChanged: (text) {
                        profile.mbti = text;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 11),

              //8行目
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedText(
                    text: "してるかな！",
                    style: AppTextStyles.profileFormatLarge,
                    mainColor: theme.mainColor,
                    outlineColor: AppColors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
