import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_colors.dart';
import 'package:hakocha/services/app_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  final List<_OnboardingPageData> pages = const [
    _OnboardingPageData(
      title: '自分だけのプロフ帳を\nつくろう！',
      subtitle: '',
      icon: Icons.bookmark_border,
    ),
    _OnboardingPageData(
      title: 'スマホを近づけるだけ！',
      subtitle: 'お互いのスマホを近付けるだけで\nプロフィール帳を交換できます！',
      icon: Icons.phone_android,
      imageAsset: 'lib/assets/images/image 85.png',
    ),
    _OnboardingPageData(
      title: 'プロフィール帳が\nどんどん増える！',
      subtitle: 'シェアするたびに\nプロフィール帳にページが追加されます！',
      icon: Icons.mail_outline,
      imageAsset: 'lib/assets/images/image 86.png',
    ),
    _OnboardingPageData(
      title: 'プロフィール帳の\nカラーを選ぼう！',
      subtitle: '',
      icon: Icons.palette,
      imageAsset: null,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _selectedColor = 'pink';

  Future<void> _next() async {
    if (_page < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      // 最終ページ: 選択したカラーを保存してホームへ遷移
      try {
        await const AppService().setProfileColor(_selectedColor);
      } catch (_) {}
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPink,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (context, index) {
                  final p = pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 32),
                        Text(
                          p.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFE64B8A),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (p.subtitle.isNotEmpty) ...[
                          const SizedBox(height: 18),
                          Text(
                            p.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                        const SizedBox(height: 36),
                        // Illustration or image
                     
if (index != pages.length - 1) ...[
  SizedBox( // ← ContainerからSizedBoxに変更
    width: 260,
    height: 260,
    // decoration（色や角丸の設定）は削除します
    child: Center(
      child: p.imageAsset != null
          ? Image.asset( // ← ClipRRectも（角丸にする必要がないので）削除しました
              p.imageAsset!,
              width: 240,
              height: 240,
              fit: BoxFit.contain,
            )
          : Icon(
              p.icon,
              size: 120,
              color: AppColors.pink4,
            ),
    ),
  ),
]else ...[
                          // 最終ページ: 横並びの2つの画像 + 小さな丸選択ボタン
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => _selectedColor = 'pink'),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'lib/assets/images/Frame 2085667445 (3).png',
                                        width: 200,
                                        height: 180,
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => _selectedColor = 'blue'),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'lib/assets/images/Frame 2085667446 (3).png',
                                        width: 150,
                                        height: 180,
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedColor = 'pink'),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: _selectedColor == 'pink'
                                              ? AppColors.pink4
                                              : Colors.grey.shade300,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _selectedColor == 'pink'
                                                ? AppColors.pink4
                                                : Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'ピンク',
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 64),
                              GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedColor = 'blue'),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: _selectedColor == 'blue'
                                              ? Colors.lightBlue
                                              : Colors.grey.shade300,
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _selectedColor == 'blue'
                                                ? Colors.lightBlue
                                                : Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'ブルー',
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (i) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: _page == i ? 40 : 10,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _page == i ? AppColors.purple4 : Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: SizedBox(
                width: 140,
                child: OutlinedButton(
                  onPressed: _next,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.purple4, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    _page == pages.length - 1 ? 'はじめる' : 'つぎへ',
                    style: TextStyle(color: AppColors.purple4, fontSize: 15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPageData {
  final String title;
  final String subtitle;
  final IconData icon;
  final String? imageAsset;

  const _OnboardingPageData({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.imageAsset,
  });
}

class _ColorOption extends StatelessWidget {
  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _ColorOption({
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected ? color : Colors.grey.shade300,
                width: selected ? 3 : 1,
              ),
            ),
            child: Center(child: Icon(Icons.book, color: color, size: 48)),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
