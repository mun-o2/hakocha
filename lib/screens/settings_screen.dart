import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/models/app_tab.dart';
import 'package:hakocha/widgets/app_bottom_navigation_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPink,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPink,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '設定',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              // 個人情報セクション
              _buildSectionTitle('個人情報'),
              const SizedBox(height: 12),
              _buildOutlinedButton(
                title: 'メールアドレス',
                trailingText: 'ochanoma046@gmail.com',
                onTap: () {
                  // メールアドレスボタンのみ遷移処理を実装
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PersonalInfoScreen(),
                      fullscreenDialog: true, // 下からスライドしてくるダイアログ風
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),

              // アプリ情報セクション
              _buildSectionTitle('アプリ情報'),
              const SizedBox(height: 12),
              _buildOutlinedButton(
                title: 'プライバシーポリシー',
                onTap: () {
                  // 遷移先の画面は未作成
                },
              ),
              const SizedBox(height: 16),
              _buildOutlinedButton(
                title: '利用規約',
                onTap: () {
                  // 遷移先の画面は未作成
                },
              ),
              const SizedBox(height: 16),
              _buildOutlinedButton(
                title: 'お問い合わせ',
                onTap: () {
                  // 遷移先の画面は未作成
                },
              ),
              const SizedBox(height: 16),

              // ロゴとバージョン
              Image.asset(
                'lib/assets/images/shareme_logo.png',
                // heightの指定を削除し、widthを指定してサイズを調整します
                width: 250, // 目標画像に近いサイズ（250〜280あたりでお好みで微調整してください）
                fit: BoxFit.contain, // 縦横比を維持したまま指定サイズに収めます
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 100,
                  width: 200,
                  color: Colors.pink.withOpacity(0.2),
                  alignment: Alignment.center,
                  child: const Text('ロゴ画像'),
                ),
              ),
              const Text(
                'バージョン1.0.1',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),

              // ログアウトボタン
              _buildLogoutButton(context),
              // const SizedBox(height: 24),
            ],
          ),
        ),
      ),

      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: 0, // プロフィール画面から来ている想定なので2
        onTap: (index) {
          final selectedTab = AppTab.values[index];

          if (selectedTab == AppTab.profile) {
            // ① プロフィールタブが押された場合：
            // 今いる設定画面を閉じるだけで、元のプロフィール画面（バーあり）に戻ります
            Navigator.pop(context);
          } else if (selectedTab == AppTab.home) {
            // ② ホームタブが押された場合：
            // main.dart の routes に定義されている '/home' を使って、
            // ナビゲーションバーを持った土台ごと新しく開き直します（初期表示がホームなので完璧に動きます）
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          } else if (selectedTab == AppTab.exchange) {
            // ③ 交換タブが押された場合：
            // 【注意】main.dartを書き換えない限り、バー付きで交換タブを直接開けません。
            // 妥協案として、一旦 '/home' に遷移させ、ユーザーに手動で交換タブを押してもらう挙動にします。
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          }
        },
      ),
    );
  }

  // セクション見出し用の部品
  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  // ピンク枠線の共通ボタン部品
  Widget _buildOutlinedButton({
    required String title,
    String? trailingText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.pink4, width: 1.5),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            if (trailingText != null)
              Text(
                trailingText,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ログアウトボタン
  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () {
        // ログアウト処理
      },
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: 160,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF8E8D9B), 
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Center(
          child: Text(
            'ログアウト',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 2枚目の画像（遷移先のメールアドレス詳細画面）
// ---------------------------------------------------------
class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.imapePickerBottomSheetSub,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // 戻るボタンを非表示
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.textPrimary, size: 28),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              '個人情報',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 60),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'メールアドレス',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    'ochanoma046@gmail.com',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // アカウント削除ボタン
            TextButton(
              onPressed: () {
                // アカウント削除処理
              },
              child: const Text(
                'アカウント削除',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE55D70), // 赤系の文字色
                ),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}