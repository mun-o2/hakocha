import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';

/// プロフィール（プロフィール帳の表紙）画面
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPink, 
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // タップ可能なプロフィール帳の画像
              GestureDetector(
                onTap: () {
                  // プロフィール帳の中身画面へ遷移
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileDetailScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  'lib/assets/images/profilebook.png', // 画像のパスを指定してください
                  width: 280, // デザインに合わせてサイズ調整してください
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// プロフィール帳の中身の画面（遷移先）
class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール帳の中身'),
        backgroundColor: const Color(0xFFF8E7EF),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'ここに別の人が書いた「プロフィール帳の中身」を表示します。',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}