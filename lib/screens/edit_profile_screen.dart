import 'package:flutter/material.dart';
import '../widgets/profile_card_left.dart';
import '../widgets/profile_card_right.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        children: const [
          // 最初に表示されるページ
          ProfileCardLeft(editable: true),

          // 2ページ目
          ProfileCardRight(editable: true),
        ],
      ),
    );
  }
}
