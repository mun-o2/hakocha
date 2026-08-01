import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hakocha/constants/app_colors.dart';

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

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    // タップ時に少しふわっと大きくなって戻る
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

    // 透明度変更
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

  Future<void> _openProfileBook() async {
    if (_isOpening) return;

    setState(() {
      _isOpening = true;
    });

    // タップした感
    HapticFeedback.lightImpact();

    // 表紙をふわっとさせる
    await _controller.forward();

    if (!mounted) return;

    // ProfileScreen内で詳細表示に切り替える
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
          ? ProfileDetailScreen(
              key: const ValueKey('profileDetail'),
              onBack: _closeProfileBook,
            )
          : _buildProfileBookCover(),
    );
  }

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
}

/// プロフィール帳の中身
class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPink,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPink,
        elevation: 0,
        leading: IconButton(
          onPressed: onBack,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.textPrimary,
          ),
        ),
        title: const Text(
          'プロフィール帳の中身',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'ここに別の人が書いた「プロフィール帳の中身」を表示します。',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textPrimary, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
