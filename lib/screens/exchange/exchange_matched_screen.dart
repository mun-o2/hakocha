import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/constants/app_text_styles.dart';
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
      color: AppColors.backgroundPink,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('交換完了！', style: AppTextStyles.titleLarge),
          const SizedBox(height: 28),
          _buildProfileCard(matchedUser),
          const SizedBox(height: 28),
          Text(
            '${provider.exchangeCount}回目の交換だよ！',
            style: AppTextStyles.subtitle,
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.pink4,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            onPressed: provider.startWriting,
            child: const Text('記入する！'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(UserProfile user) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: AppColors.pink5,
            child: const Icon(Icons.person, size: 48, color: AppColors.pink4),
          ),
          const SizedBox(height: 16),
          Text(user.name, style: AppTextStyles.userName),
        ],
      ),
    );
  }
}
