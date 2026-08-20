import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/screens/settings/service_screen.dart';
import 'package:hakocha/screens/settings/privacy_policy_screen.dart';
import 'package:hakocha/services/auth_service.dart';

typedef SignOutCallback = Future<void> Function();

class SettingsScreen extends StatelessWidget {
  final String? email;
  final SignOutCallback? onSignOut;

  const SettingsScreen({super.key, this.email, this.onSignOut});

  String get _email =>
      email ?? FirebaseAuth.instance.currentUser?.email ?? '未登録';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPink,
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: AppColors.backgroundPink,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '設定',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 21,
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
              const SizedBox(height: 18),
              // 個人情報セクション
              _buildSectionTitle('個人情報'),
              const SizedBox(height: 6),
              _buildOutlinedButton(
                title: 'メールアドレス',
                trailingText: _email,
                onTap: () {
                  // メールアドレスボタンのみ遷移処理を実装
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          PersonalInfoScreen(email: _email),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                    ),
                  );
                },
              ),
              const SizedBox(height: 25),

              // アプリ情報セクション
              _buildSectionTitle('アプリ情報'),
              const SizedBox(height: 6),
              _buildOutlinedButton(
                title: 'プライバシーポリシー',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildOutlinedButton(
                title: '利用規約',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ServiceScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildOutlinedButton(
                title: 'お問い合わせ',
                onTap: () {
                  // 遷移先の画面は未作成
                },
              ),
              const SizedBox(height: 10),

              // ロゴとバージョン
              Image.asset(
                'lib/assets/images/shareme_logo.png',
                // heightの指定を削除し、widthを指定してサイズを調整
                width: 240,
                fit: BoxFit.contain, // 縦横比を維持したまま指定サイズに収める
              ),
              const Text(
                'バージョン1.0.1',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 12),

              // ログアウトボタン
              _buildLogoutButton(context),
            ],
          ),
        ),
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
            if (trailingText != null) ...[
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  trailingText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ログアウトボタン
  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('ログアウトしますか？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('キャンセル'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: const Text('ログアウト'),
              ),
            ],
          ),
        );
        if (confirmed != true || !context.mounted) return;

        try {
          await (onSignOut?.call() ?? AuthService().signOut());
          if (!context.mounted) return;
          Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamedAndRemoveUntil('/onboarding', (route) => false);
        } catch (error) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ログアウトできませんでした。もう一度お試しください。')),
          );
          debugPrint('Sign out error: $error');
        }
      },
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: 160,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.logoutButton,
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
// 遷移先のメールアドレス詳細画面
// ---------------------------------------------------------
class PersonalInfoScreen extends StatelessWidget {
  final String email;

  const PersonalInfoScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.personalInfoScreen,
      // ▼ 設定画面と全く同じ見た目の AppBar を配置 ▼
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: AppColors.backgroundPink,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '設定',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 21,
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
      // ▼ 本文エリア（ピンク色の領域） ▼
      body: SafeArea(
        child: Column(
          children: [
            // ×ボタンを画面右上に配置
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 16.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.textPrimary,
                    size: 28,
                  ),
                  onPressed: () {
                    // 【条件2】×をクリックするとひとつ前の設定画面に戻る
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            const SizedBox(height: 8), // ×ボタンとタイトルの余白調整
            const Text(
              '個人情報',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 60),
            Padding(
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
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
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
                  color: AppColors.deleteAccountButton,
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
