import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/models/user_profile.dart';
import 'package:hakocha/providers/exchange_provider.dart';
import 'package:provider/provider.dart';

class ExchangeCompletedScreen extends StatefulWidget {
  const ExchangeCompletedScreen({super.key, required this.onOpenProfile});

  final VoidCallback onOpenProfile;

  @override
  State<ExchangeCompletedScreen> createState() =>
      _ExchangeCompletedScreenState();
}

class _ExchangeCompletedScreenState extends State<ExchangeCompletedScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExchangeProvider>();
    final matchedUser = provider.matchedUser;

    if (matchedUser == null) {
      return const SizedBox();
    }

    return SizedBox.expand(
      child: Container(
        color: _getBackgroundColor(matchedUser.themeColor),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Spacer(),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '相手に届いたよ！',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.pink4,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // ふわふわする画像（気に入らなかったら消してね）
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Image.asset(
                          'lib/assets/images/sharematched_letter.png',
                          width: 260,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    SizedBox(
                      width: 230,
                      height: 44,
                      child: OutlinedButton(
                        onPressed: () {
                          provider.resetExchange();
                          widget.onOpenProfile();
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.purple5,
                          backgroundColor: AppColors.backgroundWhite,
                          side: const BorderSide(
                            color: AppColors.purple5,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: const Text(
                          'プロフィール帳を見る',
                          style: TextStyle(
                            color: AppColors.purple5,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(ProfileThemeColor themeColor) {
    switch (themeColor) {
      case ProfileThemeColor.pink:
        return AppColors.pink5;
      case ProfileThemeColor.blue:
        return AppColors.blue5;
    }
  }
}
