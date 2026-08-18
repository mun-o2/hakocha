import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPink, // 設定画面と背景色を合わせます
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPink,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'プライバシーポリシー',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () {
            // ＜ をクリックすると元の設定画面に戻ります
            Navigator.pop(context);
          },
        ),
      ),
      // 文章が画面に収まらない場合にスクロールできるようにします
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: const Text(
            '''

しぇあme（以下、「本アプリ」）は、利用者のプライバシーを尊重し、個人情報を適切に取り扱います。

1. 取得する情報
本アプリでは、以下の情報を取得する場合があります。

- 名前
- ニックネーム
- 誕生日
- アイコン画像
- プロフィール帳に登録した情報
- GoogleまたはAppleアカウント情報（ログイン時）

2. 利用目的
取得した情報は、以下の目的で利用します。

- プロフィール帳の作成・管理
- プロフィール帳の交換機能の提供
- アカウント管理
- サービス改善
- お問い合わせ対応

3. 第三者提供
法令に基づく場合を除き、利用者の同意なく第三者へ個人情報を提供することはありません。

4. お問い合わせ
ご質問やご不明点がございましたら、お問い合わせよりご連絡ください。''',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              height: 1.6, // 行間を少し広げると文章が読みやすくなります
            ),
          ),
        ),
      ),
    );
  }
}