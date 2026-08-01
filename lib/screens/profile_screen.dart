import 'package:flutter/material.dart';
import '../widgets/profile_card_left.dart';
import '../widgets/profile_card_right.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        ProfileCardLeft(editable: false),
        ProfileCardRight(editable: false),
      ],
    );
  }
}
