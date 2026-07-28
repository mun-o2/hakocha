import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/constants/app_text_styles.dart';
import 'package:hakocha/providers/exchange_provider.dart';
import 'package:provider/provider.dart';

class ExchangeStartScreen extends StatelessWidget {
  const ExchangeStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundPink,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'スマホを近づけて\nタップしてシェア！',
            style: AppTextStyles.titleLarge.copyWith(height: 1.3),
          ),
          const SizedBox(height: 32),
          _buildIllustrationCard(context),
          const SizedBox(height: 28),
          Text('交換コードで受け取る', style: AppTextStyles.subtitle),
          const SizedBox(height: 16),
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
              final provider = context.read<ExchangeProvider>();
              provider.simulateMatch();
            },
            child: const Text('開発用：相手を見つける'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              side: const BorderSide(color: AppColors.textTertiary),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            onPressed: () {
              final provider = context.read<ExchangeProvider>();
              provider.simulateMatch();
            },
            child: const Text('コードを入力する'),
          ),
        ],
      ),
    );
  }

  Widget _buildIllustrationCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.textTertiary.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPhoneIllustration(AppColors.blue5),
          _buildPhoneIllustration(AppColors.backgroundPink),
        ],
      ),
    );
  }

  Widget _buildPhoneIllustration(Color backgroundColor) {
    return Container(
      width: 110,
      height: 170,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: const Center(
        child: Icon(Icons.smartphone, size: 64, color: AppColors.blue4),
      ),
    );
  }
}
