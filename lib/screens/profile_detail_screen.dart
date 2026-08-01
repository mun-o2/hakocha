import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/constants/app_text_styles.dart';
import 'package:hakocha/models/user_profile.dart';

class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key, required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('プロフィール帳')),
      backgroundColor: AppColors.backgroundPink,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
                radius: 52,
                backgroundColor: AppColors.pink5,
                child: const Icon(
                  Icons.person,
                  size: 56,
                  color: AppColors.pink4,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(child: Text(user.name, style: AppTextStyles.userName)),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text('交換した相手のプロフィールです。', style: AppTextStyles.bodyText),
                  SizedBox(height: 18),
                  Text(
                    '・好きなこと: おしゃべり・ライブ・お菓子作り\n・将来の夢: みんなと仲良くすること',
                    style: AppTextStyles.bodyText,
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
