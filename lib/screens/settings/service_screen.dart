import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPink, // 設定画面と背景色を合わせます
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPink,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '利用規約',
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

本アプリをご利用いただく前に、本規約をご確認ください。

第1条（利用について）
利用者は、本規約に同意した上で本アプリを利用するものとします。

第2条（禁止事項）
以下の行為を禁止します。

- 他者になりすます行為
- 他者を傷つける内容の投稿
- 法令または公序良俗に反する行為
- 本アプリの運営を妨害する行為

第3条（免責事項）
本アプリの利用により生じた損害について、運営者は故意または重大な過失がある場合を除き責任を負いません。

第4条（サービス内容）
本アプリは予告なく機能の変更・停止を行う場合があります。''',
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