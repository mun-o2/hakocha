import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/models/remote_exchange_user.dart';

class ExchangeMatchScreen extends StatelessWidget {
  const ExchangeMatchScreen({super.key, required this.matchedUser});

  final RemoteExchangeUser matchedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              const Spacer(),

              const Text(
                '見つけました！',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 32),

              // 後でプロフィール画像に変更
              const CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.purple5,
                child: Icon(Icons.person, size: 56, color: Colors.white),
              ),

              const SizedBox(height: 24),

              Text(
                matchedUser.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'この人で合っていますか？',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO:
                    // 次にconfirmationを相手端末へ送る
                    debugPrint('✅ この人と交換: ${matchedUser.name}');
                  },
                  child: const Text('この人と交換'),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('探し直す'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
