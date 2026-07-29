import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/screens/exchange/exchange_code_input_screen.dart';

class ExchangeStartScreen extends StatelessWidget {
  const ExchangeStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFFBF8FF),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 80),
            _buildTitle(),
            const SizedBox(height: 24),
            _buildIllustration(),
            const SizedBox(height: 32),
            _buildActionArea(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'スマホを近づけて\nタップしてシェア！',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF4D4643),
        fontSize: 24,
        fontFamily: 'Noto Sans JP',
        fontWeight: FontWeight.w400,
        height: 2,
      ),
    );
  }

  Widget _buildIllustration() {
    return Center(
      child: Image.asset(
        'lib/assets/images/sharescreen_image85.png',
        width: 240,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildActionArea(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 300,
          height: 140,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: ShapeDecoration(
            color: const Color(0xFFF3E9FD),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: AppColors.purple5),
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '交換コードで受け取る',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.purple5,
                  fontSize: 20,
                  fontFamily: 'Noto Sans JP',
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 16),

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.purple5,
                  backgroundColor: AppColors.backgroundWhite,
                  side: const BorderSide(color: AppColors.purple5, width: 2),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                onPressed: () {
                  // コード入力画面へ
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExchangeCodeInputScreen(),
                    ),
                  );
                },
                child: const Text(
                  'コードを入力する',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 開発用のボタン（削除予定）
        /*
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.pink4,
            foregroundColor: AppColors.backgroundWhite,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          onPressed: () {
            context.read<ExchangeProvider>().simulateMatch();
          },
          child: const Text('開発用：相手を見つける'),
        ),
        */
      ],
    );
  }

  // (UI replaced by fixed-size Stack layout above)
}
