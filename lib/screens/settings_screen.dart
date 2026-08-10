import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // 押したら前の画面に戻る
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // 「アプリ情報」の見出し
            const Text(
              'アプリ情報',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            // 4つのボタンを並べる
            _buildSettingButton('プライバシーポリシー'),
            const SizedBox(height: 12),
            _buildSettingButton('利用規約'),
            const SizedBox(height: 12),
            _buildSettingButton('特定商取引法に基づく表記'),
            const SizedBox(height: 12),
            _buildSettingButton('お問い合わせ'),
          ],
        ),
      ),
    );
  }

  // 角丸ボタンを作るための専用の部品
  Widget _buildSettingButton(String title) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}