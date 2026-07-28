import 'package:flutter/material.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_colors.dart';
import 'outlined_text.dart';
import 'profile_text_field.dart';
//instagramとXのアイコン
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:iconify_flutter/icons/bxl.dart';

// カード全体
class ProfileCardBody extends StatelessWidget {
  final bool isLeft;
  final Widget child;

  const ProfileCardBody({super.key, this.isLeft = true, required this.child});

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
                color: AppColors.pink4,
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
            child: ProfileCardMain(isLeft: true, child: child),
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
                color: AppColors.pink4,
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
            child: ProfileCardMain(isLeft: false, child: child),
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

  const ProfileCardMain({super.key, this.isLeft = true, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pink4,
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
          color: AppColors.profileCardBackground,
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

  const ProfileHeader({
    super.key,
    required this.instagramId,
    required this.xId,
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
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: 95,
                  height: 110,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEEFF8),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFFEEFF8).withValues(alpha: 0.8),
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
                      outlineColor: AppColors.pink4,
                      strokeWidth: 2.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Iconify(
                        AntDesign.instagram_outlined,
                        color: AppColors.pink4,
                        size: 26,
                      ),
                      const SizedBox(width: 23),
                      Text(instagramId, style: AppTextStyles.profileText),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Iconify(Bxl.twitter, color: AppColors.pink4, size: 26),
                      const SizedBox(width: 23),
                      Text(xId, style: AppTextStyles.profileText),
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
  const ProfileMainDescription({super.key});

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

                  ProfileInputBox(width: 100, height: 25),

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
                  ProfileInputBox(width: 80, height: 25),

                  const SizedBox(width: 4),

                  OutlinedText(
                    text: "年",
                    style: AppTextStyles.profileFormatText1,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 4),
                  ProfileInputBox(width: 50, height: 25),

                  OutlinedText(
                    text: "月",
                    style: AppTextStyles.profileFormatText1,
                    outlineColor: AppColors.white,
                  ),

                  const SizedBox(width: 4),
                  ProfileInputBox(width: 50, height: 25),

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
                  ProfileInputBox(width: 70, height: 25),
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
                  ProfileInputBox(width: 50, height: 25),
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

                  ProfileInputBox(width: 70, height: 25),

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

                  ProfileInputBox(width: 80, height: 25),

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

                  ProfileInputBox(width: 150, height: 25),

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

                  ProfileInputBox(width: 150, height: 25),
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
  const ProfileCardDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return (Stack(
      children: [
        Positioned(
          left: 20,
          bottom: 5,
          child: Column(
            children: [
              ProfileDetailItem(title: "出身地", boxLeft: 20),
              const SizedBox(width: 20),

              ProfileDetailItem(title: "兄弟構成", boxLeft: 20),
              const SizedBox(width: 20),

              ProfileDetailItem(title: "身長", boxLeft: 20),
              const SizedBox(width: 20),

              ProfileDetailItem(title: "靴のサイズ", boxLeft: 20),
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

  const ProfileDetailItem({
    super.key,
    required this.title,
    required this.boxLeft,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 50,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: boxLeft,
            top: 10,
            child: ProfileInputBox(width: 100, height: 25),
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

//LoveTalk
class ProfileLoveTalk extends StatelessWidget {
  const ProfileLoveTalk({super.key});

  @override
  Widget build(BuildContext context) {
    return (Stack(
      children: [
        Positioned(
          left: 165,
          bottom: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //1行目
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedText(
                    text: " 告白したことある？  YES",
                    style: AppTextStyles.profileFormatText2,
                    outlineColor: AppColors.pink4,
                    strokeWidth: 2.5,
                  ),
                  const SizedBox(width: 8),
                  OutlinedText(
                    text: "NO",
                    style: AppTextStyles.profileFormatText2,
                    outlineColor: AppColors.purple4,
                    strokeWidth: 2.5,
                  ),
                ],
              ),
              const SizedBox(height: 10),

              //2行目
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedText(
                    text: "告白されたことある？YES",
                    style: AppTextStyles.profileFormatText2,
                    outlineColor: AppColors.pink4,
                    strokeWidth: 2.5,
                  ),
                  const SizedBox(width: 8),
                  OutlinedText(
                    text: "NO",
                    style: AppTextStyles.profileFormatText2,
                    outlineColor: AppColors.purple4,
                    strokeWidth: 2.5,
                  ),
                ],
              ),
              const SizedBox(height: 10),

              //3行目
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedText(
                    text: " 今好きな人はいる？  YES",
                    style: AppTextStyles.profileFormatText2,
                    outlineColor: AppColors.pink4,
                    strokeWidth: 2.5,
                  ),
                  const SizedBox(width: 8),
                  OutlinedText(
                    text: "NO",
                    style: AppTextStyles.profileFormatText2,
                    outlineColor: AppColors.purple4,
                    strokeWidth: 2.5,
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

//LoveTalkのハート
class LoveTalkHeart extends StatelessWidget {
  final bool isPink;

  const LoveTalkHeart({super.key, required this.isPink});

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
            color: (isPink ? AppColors.pink4 : AppColors.purple4).withValues(
              alpha: 0.3,
            ),
            shadows: [
              Shadow(
                color: (isPink ? AppColors.pink4 : AppColors.purple4)
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
  const ProfileIfCorner({super.key});

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
                outlineColor: AppColors.pink4,
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
            const ProfileEllipse(title: "魔法がつかえたら…"),
            const SizedBox(width: 30),
            const ProfileEllipse(title: "生まれ変わるなら…"),
          ],
        ),
      ],
    ));
  }
}

//Which One?コーナー
class ProfileWhichOne extends StatelessWidget {
  const ProfileWhichOne({super.key});

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
            outlineColor: AppColors.pink4,
          ),
        ),
        const SizedBox(height: 5),
        //枠
        const ProfileWhichOneFrame(child: ProfileWhichOneContents()),
      ],
    ));
  }
}

//Which One?の枠
class ProfileWhichOneFrame extends StatelessWidget {
  final Widget? child;

  const ProfileWhichOneFrame({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 220,
      child: CustomPaint(
        painter: _ProfileWhichOnePainter(),
        child: Padding(padding: const EdgeInsets.all(10), child: child),
      ),
    );
  }
}

//Which One?の枠を描写
class _ProfileWhichOnePainter extends CustomPainter {
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

    // 内側のピンク線
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
        ..color = AppColors.profileCardBackground
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

//Which One?質問内容
class ProfileWhichOneContents extends StatelessWidget {
  const ProfileWhichOneContents({super.key});

  @override
  Widget build(BuildContext context) {
    const questions = [
      "自分は【   犬   ・   猫   】派",
      "休日は【   インドア  ・   アウトドア   】派",
      "自分は【  犬   ・   猫   】派",
      "【  きのこの山  ・  たけのこ里   】派",
      "返信は【  すぐ返信する   ・   溜めがち   】",
    ];

    return SizedBox(
      width: 230,
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: questions
              .map(
                (q) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(q, style: AppTextStyles.profileFormatText4),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

//Free Space
class ProfileFreeSpace extends StatelessWidget {
  const ProfileFreeSpace({super.key});

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
              outlineColor: AppColors.pink4,
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
            child: ProfileWhiteSquare(width: 310, height: 130),
          ),
        ],
      ),
    ));
  }
}
