import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return const EditProfileScreen();
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'トップ画面',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('プロフィール情報をここに表示します。'),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
              child: const Text("プロフィール編集"),
            ),
          ],
        ),
      ),
    );
  }
}
