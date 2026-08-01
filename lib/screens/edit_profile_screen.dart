import 'package:flutter/material.dart';
import '../widgets/profile_card_left.dart';
import '../widgets/profile_card_right.dart';
import '../constants/profile_theme.dart';
import '../services/app_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final PageController _pageController = PageController();

  ProfileCardThemeColor theme = pinkProfileCardTheme;

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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        children: [
          // 最初に表示されるページ
          ProfileCardLeft(editable: true, theme: theme),

          // 2ページ目
          ProfileCardRight(editable: true, theme: theme),
        ],
      ),
    );
  }
}
