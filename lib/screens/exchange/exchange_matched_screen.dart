import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/models/user_profile.dart';
import 'package:hakocha/providers/exchange_provider.dart';
import 'package:provider/provider.dart';

class ExchangeMatchedScreen extends StatelessWidget {
  const ExchangeMatchedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExchangeProvider>();
    final matchedUser = provider.matchedUser;

    if (matchedUser == null) {
      return const SizedBox();
    }

    return Container(
      color: _getBackgroundColor(matchedUser.themeColor),
      child: SafeArea(
        child: Column(
          children: [
            // 上部の旗
            SizedBox(
              height: 115,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -8,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'lib/assets/images/sharematched_flag.png',
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 交換完了タイトル
            const Text(
              '交換完了！',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.pink4,
                fontSize: 32,
                fontFamily: 'Noto Sans JP',
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 16),

            // attention画像 + 相手のプロフィールアイコン
            _buildUserIconArea(matchedUser),

            const SizedBox(height: 16),

            // 相手の名前
            Text(
              matchedUser.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontFamily: 'Noto Sans JP',
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 32),

            // 何回目の交換か
            Text(
              '${provider.exchangeCount}回目の交換だよ！',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.pink4,
                fontSize: 24,
                fontFamily: 'Noto Sans JP',
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 32),

            // 記入するボタン
            SizedBox(
              width: 208,
              height: 37,
              child: OutlinedButton(
                onPressed: provider.startWriting,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.purple5,
                  backgroundColor: AppColors.backgroundWhite,
                  padding: EdgeInsets.zero,
                  side: const BorderSide(color: AppColors.purple5, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: const Text(
                  '記入する！',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.purple5,
                    fontSize: 20,
                    fontFamily: 'Noto Sans JP',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
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

  /// attention画像の上に相手のプロフィールアイコンを重ねる
  Widget _buildUserIconArea(UserProfile user) {
    return SizedBox(
      width: double.infinity,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none, // 上にはみ出しても表示する
        children: [
          // アイコン周囲のattention装飾
          Transform.translate(
            offset: const Offset(0, -25), // attentionだけ上へ
            child: Image.asset(
              'lib/assets/images/sharematched_attention.png',
              width: 300,
              fit: BoxFit.contain,
            ),
          ),

          // 相手のプロフィールアイコン
          _buildUserIcon(user),
        ],
      ),
    );
  }

  /// 相手のプロフィールアイコン
  Widget _buildUserIcon(UserProfile user) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFD9D9D9),

        // iconUrl がある場合はプロフィール画像を表示
        image: user.iconUrl.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(user.iconUrl),
                fit: BoxFit.cover,
              )
            : null,
      ),

      // アイコンが未設定の場合は仮アイコン
      child: user.iconUrl.isEmpty
          ? const Icon(Icons.person, size: 64, color: AppColors.pink4)
          : null,
    );
  }
}
