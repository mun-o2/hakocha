import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/constants/app_text_styles.dart';
import 'package:hakocha/providers/exchange_provider.dart';
import 'package:hakocha/screens/profile_detail_screen.dart';
import 'package:provider/provider.dart';

class ExchangeCompletedScreen extends StatelessWidget {
  const ExchangeCompletedScreen({super.key});

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
          Text('相手に届いたよ！', style: AppTextStyles.titleLarge),
          const SizedBox(height: 32),
          Expanded(
            child: Center(
              child: Container(
                width: 212,
                height: 212,
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Icon(
                  Icons.mail_outline,
                  size: 88,
                  color: AppColors.blue4,
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.pink4,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            onPressed: () {
              final user = provider.matchedUser;
              if (user == null) {
                return;
              }
              provider.resetExchange();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProfileDetailScreen(user: user),
                ),
              );
            },
            child: const Text('プロフィール帳を見る'),
          ),
        ],
      ),
    );
  }
}
