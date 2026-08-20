import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/screens/onboarding/pages/color_onboarding_page.dart';
import 'package:hakocha/screens/onboarding/pages/collect_onboarding_page.dart';
import 'package:hakocha/services/app_service.dart';
import 'package:hakocha/widgets/onboarding/onboarding_dots.dart';

class ProfileSetupOnboardingScreen extends StatefulWidget {
  const ProfileSetupOnboardingScreen({super.key});

  @override
  State<ProfileSetupOnboardingScreen> createState() =>
      _ProfileSetupOnboardingScreenState();
}

class _ProfileSetupOnboardingScreenState
    extends State<ProfileSetupOnboardingScreen> {
  final PageController _controller = PageController();

  int _page = 0;
  String _selectedColor = 'pink';

  List<Widget> get pages => [
    ColorOnboardingPage(
      selectedColor: _selectedColor,
      onColorChanged: (color) {
        setState(() {
          _selectedColor = color;
        });
      },
    ),
    const CollectOnboardingPage(),
  ];

  Future<void> _confirmColor() async {
    await const AppService().setProfileColor(_selectedColor);

    if (!mounted) return;

    // Collectページへ
    await _controller.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );

    // Collectページを2秒表示
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    Navigator.of(context).pushReplacementNamed('/home');
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _page = index;
                  });
                },
                children: pages,
              ),
            ),

            // 元オンボーディングのDotsと同じ高さを確保
            Opacity(
              opacity: 0,
              child: OnboardingDots(currentPage: 0, pageCount: 3),
            ),

            // 元オンボーディングと同じ
            const SizedBox(height: 70),

            // Appleボタンと同じ位置
            if (_page == 0)
              SizedBox(
                width: 285,
                height: 56,
                child: ElevatedButton(
                  onPressed: _confirmColor,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.purple4,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'このカラーに決定',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            else
              const SizedBox(width: 285, height: 56),

            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
