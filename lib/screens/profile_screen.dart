import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/widgets/profile_card_left.dart';
import 'package:hakocha/widgets/profile_card_right.dart';
import 'package:hakocha/constants/profile_theme.dart';
import 'package:hakocha/services/app_service.dart';

/// プロフィール帳タブ
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  bool _isOpening = false;
  bool _isDetailOpen = false;

  ProfileCardThemeColor theme = pinkProfileCardTheme;

  @override
  void initState() {
    super.initState();

    _loadTheme();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 1.04,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 45,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.04,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 55,
      ),
    ]).animate(_controller);

    _fadeAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.88),
        weight: 45,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.88, end: 1.0),
        weight: 55,
      ),
    ]).animate(_controller);
  }

  Future<void> _loadTheme() async {
    final color = await const AppService().getProfileColor();

    if (!mounted) return;

    setState(() {
      theme = color == 'pink' ? pinkProfileCardTheme : blueProfileCardTheme;
    });
  }

  Future<void> _openProfileBook() async {
    if (_isOpening) return;

    setState(() {
      _isOpening = true;
    });

    HapticFeedback.lightImpact();

    await _controller.forward();

    if (!mounted) return;

    setState(() {
      _isDetailOpen = true;
      _isOpening = false;
    });

    _controller.reset();
  }

  void _closeProfileBook() {
    setState(() {
      _isDetailOpen = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: _isDetailOpen
          ? _buildProfileBookDetail()
          : _buildProfileBookCover(),
    );
  }

  /// プロフィール帳の表紙
  Widget _buildProfileBookCover() {
    return Scaffold(
      key: const ValueKey('profileCover'),
      backgroundColor: AppColors.backgroundPink,
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: _openProfileBook,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Image.asset(
                  'lib/assets/images/profilebook.png',
                  width: 280,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// プロフィール帳の中身
  Widget _buildProfileBookDetail() {
    return Scaffold(
      key: const ValueKey('profileDetail'),
      backgroundColor: AppColors.backgroundPink,
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              children: [
                ProfileCardLeft(editable: false, theme: theme),
                ProfileCardRight(editable: false, theme: theme),
              ],
            ),

            // 表紙に戻る
            Positioned(
              top: 8,
              left: 8,
              child: IconButton(
                onPressed: _closeProfileBook,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
