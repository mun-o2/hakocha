import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/models/user_profile.dart';
import 'package:hakocha/providers/exchange_provider.dart';
import 'package:provider/provider.dart';

class ExchangeCompletedScreen extends StatelessWidget {
  const ExchangeCompletedScreen({super.key, required this.onOpenProfile});

  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExchangeProvider>();
    final matchedUser = provider.matchedUser;

    if (matchedUser == null) {
      return const SizedBox();
    }

    return SizedBox.expand(
      child: Container(
        color: _getBackgroundColor(matchedUser.themeColor),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Spacer(),

                // タイトル・画像・ボタンを1つのまとまりにする
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // タイトル
                    const Text(
                      '相手に届いたよ！',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.pink4,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // 画像
                    Image.asset(
                      'lib/assets/images/sharematched_letter.png',
                      width: 260,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 40),

                    // ボタン
                    SizedBox(
                      width: 230,
                      height: 44,
                      child: OutlinedButton(
                        onPressed: () {
                          // プロフィール帳画面へ遷移
                          provider.resetExchange();
                          onOpenProfile();
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.purple5,
                          backgroundColor: AppColors.backgroundWhite,
                          side: const BorderSide(
                            color: AppColors.purple5,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: const Text(
                          'プロフィール帳を見る',
                          style: TextStyle(
                            color: AppColors.purple5,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 相手が選択しているカラーを背景色として使用
  Color _getBackgroundColor(ProfileThemeColor themeColor) {
    switch (themeColor) {
      case ProfileThemeColor.pink:
        return AppColors.pink5;
      case ProfileThemeColor.blue:
        return AppColors.blue5;
    }
  }
}
