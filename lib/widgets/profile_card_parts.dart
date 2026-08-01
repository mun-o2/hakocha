import 'package:flutter/material.dart';
import 'package:hakocha/models/profile_data.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_colors.dart';
import 'outlined_text.dart';
import 'profile_text_field.dart';
//instagramとXのアイコン
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:iconify_flutter/icons/bxl.dart';

import 'profile_edit_parts.dart';
import '../dummy/dummy_profile.dart';
import 'image_picker_sheet.dart';
import '../constants/profile_theme.dart';

// カード全体
class ProfileCardBody extends StatelessWidget {
  final bool isLeft;
  final Widget child;
  final ProfileCardThemeColor theme;

  const ProfileCardBody({
    super.key,
    this.isLeft = true,
    required this.child,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    //左側に出っ張りがある（表）
    if (isLeft) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          // 出っ張り
          Positioned(
            left: -25,
            top: 0,
            bottom: 280,
            child: Container(
              width: 80,
              decoration: BoxDecoration(
                color: theme.mainColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          // 穴
          Positioned(
            left: -6,
            top: 10,
            bottom: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 23,
            right: 0,
            top: 0,
            bottom: 0,
            child: ProfileCardMain(isLeft: true, theme: theme, child: child),
          ),
        ],
      );
    }
    //右側に出っ張りがある（裏）
    else {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          // 出っ張り
          Positioned(
            right: -25,
            top: 0,
            bottom: 280,
            child: Container(
              width: 80,
              decoration: BoxDecoration(
                color: theme.mainColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          // 穴
          Positioned(
            right: -6,
            top: 10,
            bottom: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 23,
            top: 0,
            bottom: 0,
            child: ProfileCardMain(isLeft: false, theme: theme, child: child),
          ),
        ],
      );
    }
  }
}

// カード本体
class ProfileCardMain extends StatelessWidget {
  final bool isLeft;
  final Widget child;
  final ProfileCardThemeColor theme;

  const ProfileCardMain({
    super.key,
    this.isLeft = true,
    required this.child,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.mainColor,
        borderRadius: BorderRadius.only(
          topLeft: isLeft ? Radius.zero : const Radius.circular(30),
          topRight: isLeft ? const Radius.circular(30) : Radius.zero,
          bottomLeft: const Radius.circular(30),
          bottomRight: const Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(4),

      child: Container(
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: isLeft ? Radius.zero : const Radius.circular(27),
            topRight: isLeft ? const Radius.circular(27) : Radius.zero,
            bottomLeft: const Radius.circular(27),
            bottomRight: const Radius.circular(27),
          ),
        ),
        child: child,
      ),
    );
  }
}

//白い四角
class ProfileWhiteSquare extends StatelessWidget {
  final double width;
  final double height;

  const ProfileWhiteSquare({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return (Positioned(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.7),
          boxShadow: [
            BoxShadow(
              color: AppColors.white.withValues(alpha: 0.8),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    ));
  }
}

//似顔絵・SNS部分
class ProfileHeader extends StatelessWidget {
  final String instagramId;
  final String xId;
  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileHeader({
    super.key,
    required this.instagramId,
    required this.xId,
    required this.editable,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 45,
      top: 70,
      child: SizedBox(
        width: 280,
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
                    width: 95,
                    height: 110,
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
                      style: AppTextStyles.profileFormatText1,
                      outlineColor: AppColors.white,
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
                      strokeWidth: 2.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Iconify(
                        AntDesign.instagram_outlined,
                        color: theme.mainColor,
                        size: 26,
                      ),
                      const SizedBox(width: 23),
                      Expanded(
                        child: editable
                            ? ProfileEditableText(
                                value: instagramId,
                                editable: editable,
                                onChanged: (text) {
                                  dummyProfile.instagramId = text;
                                },
                              )
                            : Text(
                                instagramId,
                                style: AppTextStyles.profileText,
                              ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Iconify(Bxl.twitter, color: theme.mainColor, size: 26),
                      const SizedBox(width: 23),
                      Expanded(
                        child: editable
                            ? ProfileEditableText(
                                value: xId,
                                editable: editable,
                                onChanged: (text) {
                                  dummyProfile.xId = text;
                                },
                              )
                            : Text(xId, style: AppTextStyles.profileText),
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

//基本プロフィール本文
class ProfileMainDescription extends StatelessWidget {
  final bool editable;
  const ProfileMainDescription({super.key, this.editable = true});

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
                    style: AppTextStyles.profileFormatText1,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 20),

                  ProfileInputBox(
                    width: 100,
                    height: 25,
                    value: dummyProfile.name,
                    editable: editable,
                    onChanged: (text) {
                      dummyProfile.name = text;
                    },
                  ),

                  const SizedBox(width: 20),

                  OutlinedText(
                    text: "で、",
                    style: AppTextStyles.profileFormatText1,
                    outlineColor: AppColors.white,
                  ),
                ],
              ),

              const SizedBox(height: 11),

              //2行目
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileInputBox(
                    width: 80,
                    height: 25,
                    value: dummyProfile.birthYear,
                    editable: editable,
                    onChanged: (text) {
                      dummyProfile.birthYear = text;
                    },
                  ),

                  const SizedBox(width: 4),

                  OutlinedText(
                    text: "年",
                    style: AppTextStyles.profileFormatText1,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 4),
                  ProfileInputBox(
                    width: 50,
                    height: 25,
                    value: dummyProfile.birthMonth,
                    editable: editable,
                    onChanged: (text) {
                      dummyProfile.birthMonth = text;
                    },
                  ),

                  OutlinedText(
                    text: "月",
                    style: AppTextStyles.profileFormatText1,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 4),
                  ProfileInputBox(
                    width: 50,
                    height: 25,
                    value: dummyProfile.birthDay,
                    editable: editable,
                    onChanged: (text) {
                      dummyProfile.birthDay = text;
                    },
                  ),

                  OutlinedText(
                    text: "日生まれの",
                    style: AppTextStyles.profileFormatText1,
                    outlineColor: AppColors.white,
                  ),
                ],
              ),

              const SizedBox(height: 11),

              //3行目
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileInputBox(
                    width: 70,
                    height: 25,
                    value: dummyProfile.zodiacSign,
                    editable: editable,
                    onChanged: (text) {
                      dummyProfile.zodiacSign = text;
                    },
                  ),
                  const SizedBox(width: 4),

                  OutlinedText(
                    text: "座だよ！",
                    style: AppTextStyles.profileFormatText1,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 11),

                  OutlinedText(
                    text: "血液型は",
                    style: AppTextStyles.profileFormatText1,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 4),
                  ProfileInputBox(
                    width: 50,
                    height: 25,
                    value: dummyProfile.bloodType,
                    editable: editable,
                    onChanged: (text) {
                      dummyProfile.bloodType = text;
                    },
                  ),
                  const SizedBox(width: 4),

                  OutlinedText(
                    text: "型！",
                    style: AppTextStyles.profileFormatText1,
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
                    style: AppTextStyles.profileFormatText1,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 4),

                  ProfileInputBox(
                    width: 70,
                    height: 25,
                    value: dummyProfile.mbti,
                    editable: editable,
                    onChanged: (text) {
                      dummyProfile.mbti = text;
                    },
                  ),

                  const SizedBox(width: 4),

                  OutlinedText(
                    text: "だよ！",
                    style: AppTextStyles.profileFormatText1,
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
                    style: AppTextStyles.profileFormatText1,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 4),

                  ProfileInputBox(
                    width: 80,
                    height: 25,
                    value: dummyProfile.nickname,
                    editable: editable,
                    onChanged: (text) {
                      dummyProfile.nickname = text;
                    },
                  ),

                  const SizedBox(width: 4),

                  OutlinedText(
                    text: "って呼ばれてて、",
                    style: AppTextStyles.profileFormatText1,
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
                    style: AppTextStyles.profileFormatText1,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 4),

                  ProfileInputBox(
                    width: 150,
                    height: 25,
                    value: dummyProfile.personality,
                    editable: editable,
                    onChanged: (text) {
                      dummyProfile.personality = text;
                    },
                  ),

                  const SizedBox(width: 4),

                  OutlinedText(
                    text: "な性格だと",
                    style: AppTextStyles.profileFormatText1,
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
                    style: AppTextStyles.profileFormatText1,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 11),

                  OutlinedText(
                    text: "休みの日は",
                    style: AppTextStyles.profileFormatText1,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 8),

                  ProfileInputBox(
                    width: 150,
                    height: 25,
                    value: dummyProfile.holidayLife,
                    editable: editable,
                    onChanged: (text) {
                      dummyProfile.holidayLife = text;
                    },
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
                    style: AppTextStyles.profileFormatText1,
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

//詳細プロフィール文
class ProfileCardDetail extends StatelessWidget {
  final bool editable;
  const ProfileCardDetail({super.key, this.editable = true});

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
                value: dummyProfile.birthplace,
                editable: editable,
              ),
              const SizedBox(width: 20),

              ProfileDetailItem(
                title: "兄弟構成",
                boxLeft: 20,
                value: dummyProfile.brothers,
                editable: editable,
              ),
              const SizedBox(width: 20),

              ProfileDetailItem(
                title: "身長",
                boxLeft: 20,
                value: dummyProfile.height,
                editable: editable,
              ),
              const SizedBox(width: 20),

              ProfileDetailItem(
                title: "靴のサイズ",
                boxLeft: 20,
                value: dummyProfile.shoeSize,
                editable: editable,
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    ));
  }
}

//詳細プロフィール部分フォーマット
class ProfileDetailItem extends StatelessWidget {
  final String title;
  final double boxLeft;
  final String value;
  final bool editable;

  const ProfileDetailItem({
    super.key,
    required this.title,
    required this.boxLeft,
    required this.value,
    required this.editable,
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
            child: ProfileInputBox(
              width: 100,
              height: 25,
              value: value,
              editable: editable,
              onChanged: (text) {
                dummyProfile.zodiacSign = text;
              },
            ),
          ),

          Positioned(
            left: 0,
            top: 0,
            child: OutlinedText(
              text: title,
              style: AppTextStyles.profileFormatText4,
              outlineColor: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// LoveTalk
class ProfileLoveTalk extends StatefulWidget {
  final bool editable;
  final ProfileCardThemeColor theme;
  const ProfileLoveTalk({super.key, this.editable = true, required this.theme});

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OutlinedText(
              text: "LoveTalk",
              style: AppTextStyles.profileTitle,
              outlineColor: widget.theme.mainColor,
            ),

            const SizedBox(height: 12),

            ProfileYesNoSelector(
              question: "告白したことある？",
              value: dummyProfile.confessed,
              editable: widget.editable,
              theme: widget.theme,
              onChanged: (v) {
                setState(() {
                  dummyProfile.confessed = v;
                });
              },
            ),

            const SizedBox(height: 8),

            ProfileYesNoSelector(
              question: "告白されたことある？",
              value: dummyProfile.beenConfessed,
              editable: widget.editable,
              theme: widget.theme,
              onChanged: (v) {
                setState(() {
                  dummyProfile.beenConfessed = v;
                });
              },
            ),

            const SizedBox(height: 8),

            ProfileYesNoSelector(
              question: "今好きな人はいる？",
              value: dummyProfile.hasCrush,
              editable: widget.editable,
              theme: widget.theme,
              onChanged: (v) {
                setState(() {
                  dummyProfile.hasCrush = v;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

//YES・NO質問のフォーマット
class ProfileYesNoSelector extends StatelessWidget {
  final String question;
  final YesNoAnswer value;
  final ValueChanged<YesNoAnswer> onChanged;
  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileYesNoSelector({
    super.key,
    required this.question,
    required this.value,
    required this.onChanged,
    required this.editable,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          child: Align(
            alignment: Alignment.centerRight,
            child: OutlinedText(
              text: question,
              style: AppTextStyles.profileFormatText2,
              outlineColor: theme.mainColor,
              strokeWidth: 2.5,
            ),
          ),
        ),

        const SizedBox(width: 3),

        YesNoButton(
          label: "YES",
          value: value,
          myValue: YesNoAnswer.yes,
          onChanged: onChanged,
          editable: editable,
          theme: theme,
        ),

        const SizedBox(width: 8),

        YesNoButton(
          label: "NO",
          value: value,
          myValue: YesNoAnswer.no,
          onChanged: onChanged,
          editable: editable,
          theme: theme,
        ),
      ],
    );
  }
}

//二択のボタンフォーマット
class YesNoButton extends StatelessWidget {
  final String label;
  final YesNoAnswer value;
  final YesNoAnswer myValue;
  final ValueChanged<YesNoAnswer> onChanged;
  final bool editable;
  final ProfileCardThemeColor theme;

  const YesNoButton({
    super.key,
    required this.label,
    required this.value,
    required this.myValue,
    required this.onChanged,
    required this.editable,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == myValue;

    return SizedBox(
      width: 25,
      height: 20,
      child: InkWell(
        onTap: editable
            ? () {
                if (selected) {
                  onChanged(YesNoAnswer.unknown);
                } else {
                  onChanged(myValue);
                }
              }
            : null,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            OutlinedText(
              text: label,
              style: AppTextStyles.profileFormatText2,
              outlineColor: myValue == YesNoAnswer.yes
                  ? theme.mainColor
                  : AppColors.purple4,
              strokeWidth: 2.5,
            ),
            selected
                ? const Icon(
                    Icons.circle_outlined,
                    size: 22,
                    color: AppColors.circleOutlined,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

//LoveTalkのハート
class LoveTalkHeart extends StatelessWidget {
  final bool isPink;
  final ProfileCardThemeColor theme;

  const LoveTalkHeart({super.key, required this.isPink, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: (isPink ? 0.88 : 1.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 外側ピンク
          Icon(
            Icons.favorite,
            size: (isPink ? 300 : 120),
            color: (isPink ? theme.mainColor : AppColors.purple4).withValues(
              alpha: 0.3,
            ),
            shadows: [
              Shadow(
                color: (isPink ? theme.mainColor : AppColors.purple4)
                    .withValues(alpha: 0.3),
                blurRadius: 7,
              ),
            ],
          ),

          // 境界ぼんやり白
          Icon(
            Icons.favorite,
            size: (isPink ? 282 : 107),
            color: AppColors.white.withValues(alpha: 0.3),
            shadows: [Shadow(color: AppColors.white, blurRadius: 5)],
          ),

          // 白
          Icon(
            Icons.favorite,
            size: (isPink ? 240 : 102),
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}

// 白い楕円
class ProfileEllipse extends StatelessWidget {
  final String title;
  final Widget? child;
  final double top;

  const ProfileEllipse({
    super.key,
    required this.title,
    this.child,
    this.top = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      child: SizedBox(
        width: 145,
        height: 110,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.white.withValues(alpha: 0.8),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: child,
            ),

            // 項目名
            Positioned(
              left: 15,
              top: 5,
              child: OutlinedText(
                text: title,
                style: AppTextStyles.profileFormatText4,
                outlineColor: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//もしもコーナー
class ProfileIfCorner extends StatelessWidget {
  final String ifMagicWish;
  final String ifNextLife;
  final bool editable;
  final ProfileCardThemeColor theme;

  const ProfileIfCorner({
    super.key,
    required this.ifMagicWish,
    required this.ifNextLife,
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
              ),
            ),
            const SizedBox(width: 20),

            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: OutlinedText(
                text: "もしもコーナー",
                style: AppTextStyles.profileFormatText4,
                outlineColor: AppColors.white,
                strokeWidth: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        Row(
          children: [
            const SizedBox(width: 30),
            ProfileEllipse(
              title: "魔法がつかえたら…",
              child: Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Center(
                  child: ProfileEllipseInput(
                    width: 120,
                    value: ifMagicWish,
                    editable: editable,
                    onChanged: (text) {
                      dummyProfile.ifMagicWish = text;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30),
            ProfileEllipse(
              title: "生まれ変わるなら…",
              child: Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Center(
                  child: ProfileEllipseInput(
                    width: 120,
                    value: ifNextLife,
                    editable: editable,
                    onChanged: (text) {
                      dummyProfile.ifNextLife = text;
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

//Which One?コーナー
class ProfileWhichOne extends StatelessWidget {
  final bool editable;
  final ProfileCardThemeColor theme;
  const ProfileWhichOne({super.key, this.editable = true, required this.theme});

  @override
  Widget build(BuildContext context) {
    return (Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedText(
          text: "あなたはどっち派？",
          style: AppTextStyles.profileFormatText4,
          outlineColor: AppColors.white,
          strokeWidth: 2,
        ),

        // Which One?見出し
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 0),
          child: OutlinedText(
            text: "Which One?",
            style: AppTextStyles.profileTitle,
            outlineColor: theme.mainColor,
          ),
        ),
        const SizedBox(height: 5),
        //枠
        ProfileWhichOneFrame(
          theme: theme,
          child: ProfileWhichOneContents(theme: theme, editable: editable),
        ),
      ],
    ));
  }
}

//Which One?の枠
class ProfileWhichOneFrame extends StatelessWidget {
  final Widget? child;
  final ProfileCardThemeColor theme;

  const ProfileWhichOneFrame({super.key, this.child, required this.theme});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 220,
      child: CustomPaint(
        painter: _ProfileWhichOnePainter(theme: theme),
        child: Padding(padding: const EdgeInsets.all(10), child: child),
      ),
    );
  }
}

//Which One?の枠を描写
class _ProfileWhichOnePainter extends CustomPainter {
  final ProfileCardThemeColor theme;

  _ProfileWhichOnePainter({required this.theme});
  @override
  void paint(Canvas canvas, Size size) {
    const double cut = 10;

    // 外側（白）
    final outerPath = Path()
      ..moveTo(cut, 0)
      ..lineTo(size.width - cut, 0)
      ..arcToPoint(
        Offset(size.width, cut),
        radius: const Radius.circular(cut),
        clockwise: false,
      )
      ..lineTo(size.width, size.height - cut)
      ..arcToPoint(
        Offset(size.width - cut, size.height),
        radius: const Radius.circular(cut),
        clockwise: false,
      )
      ..lineTo(cut, size.height)
      ..arcToPoint(
        Offset(0, size.height - cut),
        radius: const Radius.circular(cut),
        clockwise: false,
      )
      ..lineTo(0, cut)
      ..arcToPoint(
        Offset(cut, 0),
        radius: const Radius.circular(cut),
        clockwise: false,
      )
      ..close();

    canvas.drawPath(outerPath, Paint()..color = AppColors.white);

    // 内側のテーマカラー線
    final innerPath = Path()
      ..moveTo(cut + 8, 8)
      ..lineTo(size.width - cut - 8, 8)
      ..arcToPoint(
        Offset(size.width - 8, cut + 8),
        radius: const Radius.circular(cut),
        clockwise: false,
      )
      ..lineTo(size.width - 8, size.height - cut - 8)
      ..arcToPoint(
        Offset(size.width - cut - 8, size.height - 8),
        radius: const Radius.circular(cut),
        clockwise: false,
      )
      ..lineTo(cut + 8, size.height - 8)
      ..arcToPoint(
        Offset(8, size.height - cut - 8),
        radius: const Radius.circular(cut),
        clockwise: false,
      )
      ..lineTo(8, cut + 8)
      ..arcToPoint(
        Offset(cut + 8, 8),
        radius: const Radius.circular(cut),
        clockwise: false,
      )
      ..close();

    canvas.drawPath(
      innerPath,
      Paint()
        ..color = theme.backgroundColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

//Which One?質問内容
class ProfileWhichOneContents extends StatefulWidget {
  final bool editable;
  final ProfileCardThemeColor theme;
  const ProfileWhichOneContents({
    super.key,
    this.editable = true,
    required this.theme,
  });

  @override
  State<ProfileWhichOneContents> createState() =>
      _ProfileWhichOneContentsState();
}

class _ProfileWhichOneContentsState extends State<ProfileWhichOneContents> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileWhichOneSelector(
              prefix: "自分は【",
              leftLabel: "   犬   ",
              rightLabel: "   猫   ",
              suffix: "】派",
              theme: widget.theme,
              value: dummyProfile.dogOrCat,
              editable: widget.editable,
              onChanged: (v) {
                setState(() {
                  dummyProfile.dogOrCat = v;
                });
              },
            ),

            const SizedBox(height: 12),

            ProfileWhichOneSelector(
              prefix: "休日は【",
              leftLabel: "   インドア   ",
              rightLabel: "   アウトドア   ",
              suffix: "】派",
              theme: widget.theme,
              value: dummyProfile.indoorOrOutdoor,
              editable: widget.editable,
              onChanged: (v) {
                setState(() {
                  dummyProfile.indoorOrOutdoor = v;
                });
              },
            ),

            const SizedBox(height: 12),

            ProfileWhichOneSelector(
              prefix: "絶叫系は【",
              leftLabel: "   乗れる   ",
              rightLabel: "   乗れない   ",
              suffix: "】",
              theme: widget.theme,
              value: dummyProfile.thrill,
              editable: widget.editable,
              onChanged: (v) {
                setState(() {
                  dummyProfile.thrill = v;
                });
              },
            ),

            const SizedBox(height: 12),

            ProfileWhichOneSelector(
              prefix: "【",
              leftLabel: "   きのこの山   ",
              rightLabel: "   たけのこの里   ",
              suffix: "】派",
              theme: widget.theme,
              value: dummyProfile.kinokoOrTakenoko,
              editable: widget.editable,
              onChanged: (v) {
                setState(() {
                  dummyProfile.kinokoOrTakenoko = v;
                });
              },
            ),

            const SizedBox(height: 12),

            ProfileWhichOneSelector(
              prefix: "返信は【",
              leftLabel: "   すぐ返信する   ",
              rightLabel: "   溜めがち   ",
              suffix: "】",
              theme: widget.theme,
              value: dummyProfile.reply,
              editable: widget.editable,
              onChanged: (v) {
                setState(() {
                  dummyProfile.reply = v;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

//Which One?質問フォーマット
class ProfileWhichOneSelector extends StatelessWidget {
  final String prefix;
  final String leftLabel;
  final String rightLabel;
  final String suffix;
  final ProfileCardThemeColor theme;

  final WhichOneAnswer value;
  final ValueChanged<WhichOneAnswer> onChanged;

  final bool editable;
  const ProfileWhichOneSelector({
    super.key,
    required this.prefix,
    required this.leftLabel,
    required this.rightLabel,
    required this.suffix,
    required this.value,
    required this.onChanged,
    required this.editable,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(prefix, style: AppTextStyles.profileFormatText4),

        WhichOneChoiceButton(
          label: leftLabel,
          value: value,
          myValue: WhichOneAnswer.left,
          editable: editable,
          theme: theme,
          onChanged: onChanged,
        ),

        SizedBox(
          width: 18,
          child: WhichOneChoiceButton(
            label: "・",
            value: value,
            myValue: WhichOneAnswer.center,
            editable: editable,
            theme: theme,
            onChanged: onChanged,
          ),
        ),

        WhichOneChoiceButton(
          label: rightLabel,
          value: value,
          myValue: WhichOneAnswer.right,
          editable: editable,
          theme: theme,
          onChanged: onChanged,
        ),

        Text(suffix, style: AppTextStyles.profileFormatText4),
      ],
    );
  }
}

//Which One?の選択ボタンフォーマット
class WhichOneChoiceButton extends StatelessWidget {
  final String label;
  final WhichOneAnswer value;
  final WhichOneAnswer myValue;
  final bool editable;
  final ProfileCardThemeColor theme;
  final ValueChanged<WhichOneAnswer> onChanged;

  const WhichOneChoiceButton({
    super.key,
    required this.label,
    required this.value,
    required this.myValue,
    required this.onChanged,
    required this.editable,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == myValue;

    return SizedBox(
      height: 26,
      child: InkWell(
        onTap: editable
            ? () {
                if (selected) {
                  onChanged(WhichOneAnswer.unknown);
                } else {
                  onChanged(myValue);
                }
              }
            : null,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(label, style: AppTextStyles.profileFormatText4),

            if (selected)
              const Icon(
                Icons.circle_outlined,
                size: 22,
                color: AppColors.circleOutlined,
              ),
          ],
        ),
      ),
    );
  }
}

//Free Space
class ProfileFreeSpace extends StatelessWidget {
  final String freeSpace;
  final bool editable;
  final ProfileCardThemeColor theme;
  const ProfileFreeSpace({
    super.key,
    required this.freeSpace,
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
            ),
          ),
          Positioned(
            left: 160,
            top: 40,
            child: Align(
              alignment: Alignment.centerRight,
              child: OutlinedText(
                text: "ここは自由に記入してね",
                style: AppTextStyles.profileFormatText4,
                outlineColor: AppColors.white,
                strokeWidth: 2,
              ),
            ),
          ),

          // 入力欄
          Positioned(
            left: 0,
            top: 65,
            child: Stack(
              children: [
                const ProfileWhiteSquare(width: 310, height: 130),

                Positioned(
                  left: 5,
                  top: 5,
                  child: ProfileFreeSpaceInput(
                    width: 300,
                    height: 120,
                    value: freeSpace,
                    editable: editable,
                    onChanged: (text) {
                      dummyProfile.freeSpace = text;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
