import 'package:flutter/material.dart';
import '../widgets/profile_card_left.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Center(child: ProfileCardLeft()));
  }
}
