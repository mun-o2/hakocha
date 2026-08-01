import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'package:hakocha/dummy/dummy_profile.dart';
import 'package:hakocha/screens/settings_screen.dart';
import 'package:hakocha/constants/app_colors.dart';
import '../constants/profile_theme.dart';
import '../services/app_service.dart';
import '../constants/dummy_home_data.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  bool isEditing = false;
  ProfileCardThemeColor theme = pinkProfileCardTheme;

  late DummyHomeData dummyHomeData;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final color = await const AppService().getProfileColor();

    setState(() {
      theme = color == 'pink' ? pinkProfileCardTheme : blueProfileCardTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    dummyHomeData = theme == pinkProfileCardTheme
        ? DummyHomeData1
        : DummyHomeData2;

    if (isEditing) {
      return EditProfileScreen();
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundPink,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.settings,
            color: AppColors.textSecondary,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // --- 1. プロフィールカード ---
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: theme.mainColor, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColors.textTertiary,
                  ),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dummyHomeData.userName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),

                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            isEditing = true;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.purple4,
                          side: const BorderSide(color: AppColors.purple4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: const Size(120, 32),
                        ),
                        child: const Text('プロフィール編集'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --- 2. 交換人数＆ページ数カード ---
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.pink4, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem('交換した人数', dummyHomeData.exchangeCount, '人'),
                  Container(
                    width: 1,
                    height: 50,
                    color: AppColors.textTertiary,
                  ),
                  _buildStatItem(
                    'プロフィール帳',
                    dummyHomeData.profilePageCount,
                    'ページ',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // --- 3. お知らせセクション ---
            const Text(
              'お知らせ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 40.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.pink4, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                dummyHomeData.notification1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 40.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.pink4, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                dummyHomeData.notification2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 数字の部分を作るための専用部品
  Widget _buildStatItem(String title, String number, String unit) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              number,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.0,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 2),
            Text(
              unit,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(width: 60, height: 2, color: AppColors.pink4),
      ],
    );
  }
}
