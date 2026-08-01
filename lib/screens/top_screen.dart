import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/constants/app_text_styles.dart';
import 'package:hakocha/constants/dummy_home_data.dart';
import 'package:hakocha/screens/edit_profile_screen.dart';
import 'package:hakocha/screens/settings_screen.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  bool isEditing = false;
  bool isLoadingProfile = false;

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;

    if (isLoadingProfile) {
      currentScreen = const _ProfileLoadingScreen(key: ValueKey('loading'));
    } else if (isEditing) {
      currentScreen = const EditProfileScreen(key: ValueKey('edit'));
    } else {
      currentScreen = _buildTopScreen(key: const ValueKey('top'));
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.98, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
      child: currentScreen,
    );
  }

  Widget _buildTopScreen({Key? key}) {
    return Scaffold(
      key: key,
      backgroundColor: AppColors.backgroundPink,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 18),

                // 設定ボタン
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 21),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.settings_outlined,
                        size: 42,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 43),

                _buildProfileCard(),

                const SizedBox(height: 72),

                _buildStatsCard(),

                const SizedBox(height: 18),

                const SizedBox(
                  width: 295,
                  child: Text('お知らせ', style: AppTextStyles.titleLarge),
                ),

                const SizedBox(height: 18),

                _buildNotificationCard(),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: 295,
      height: 163,
      decoration: _cardDecoration(),
      child: Stack(
        children: [
          const Positioned(
            left: 40,
            top: 16,
            child: CircleAvatar(
              radius: 39.5,
              backgroundColor: Color(0xFFD9D9D9),
            ),
          ),

          Positioned(
            left: 155,
            top: 39,
            child: Text(DummyHomeData.userName, style: AppTextStyles.userName),
          ),

          Positioned(
            left: 60,
            bottom: 12,
            child: SizedBox(
              width: 170,
              height: 29,
              child: OutlinedButton(
                onPressed: () async {
                  setState(() {
                    isLoadingProfile = true;
                  });

                  await Future.delayed(const Duration(milliseconds: 1200));

                  if (!mounted) return;

                  setState(() {
                    isLoadingProfile = false;
                    isEditing = true;
                  });
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>((
                    states,
                  ) {
                    if (states.contains(WidgetState.pressed)) {
                      return AppColors.purple5.withValues(alpha: 0.12);
                    }

                    return Colors.white;
                  }),
                  overlayColor: WidgetStateProperty.all(
                    AppColors.purple5.withValues(alpha: 0.10),
                  ),
                  side: WidgetStateProperty.all(
                    const BorderSide(color: AppColors.purple5, width: 2),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
                child: Text(
                  'プロフィール編集',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.actionText.copyWith(height: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      width: 295,
      height: 107,
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              '交換した人数',
              DummyHomeData.exchangedCount,
              '人',
              88,
            ),
          ),

          Container(width: 1, height: 83, color: AppColors.pink4),

          Expanded(
            child: _buildStatItem(
              'プロフィール帳',
              DummyHomeData.profilePageCount,
              'ページ',
              114,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String title,
    String number,
    String unit,
    double underlineWidth,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: AppTextStyles.bodyMedium),

        const SizedBox(height: 4),

        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: number, style: AppTextStyles.numberLarge),
              TextSpan(text: unit, style: AppTextStyles.numberUnit),
            ],
          ),
        ),

        Container(width: underlineWidth, height: 3, color: AppColors.pink4),
      ],
    );
  }

  Widget _buildNotificationCard() {
    return Container(
      width: 295,
      height: 128,
      alignment: Alignment.center,
      decoration: _cardDecoration(),
      child: Text(
        DummyHomeData.notification,
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyText,
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: AppColors.pink4, width: 3),
      borderRadius: BorderRadius.circular(12),
    );
  }
}

/// プロフィール読み込み中
class _ProfileLoadingScreen extends StatefulWidget {
  const _ProfileLoadingScreen({super.key});

  @override
  State<_ProfileLoadingScreen> createState() => _ProfileLoadingScreenState();
}

class _ProfileLoadingScreenState extends State<_ProfileLoadingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(
      begin: 0.35,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scaleAnimation = Tween<double>(
      begin: 0.94,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPink,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.auto_stories_rounded,
                  size: 54,
                  color: AppColors.pink4,
                ),

                const SizedBox(height: 18),

                Text('プロフィール帳をひらいています...', style: AppTextStyles.subtitle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
