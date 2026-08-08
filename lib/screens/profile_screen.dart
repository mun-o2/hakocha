import 'package:flutter/material.dart';
import '../widgets/profile_card_left.dart';
import '../widgets/profile_card_right.dart';
import '../constants/profile_theme.dart';
import '../services/app_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        children: [
          // 1ページ目
          LayoutBuilder(
            builder: (context, constraints) {
              final scale = constraints.maxWidth / 360;

              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: SizedBox(
                    width: constraints.maxWidth,
                    child: Center(
                      child: Transform.scale(
                        scale: scale < 1 ? scale : 1,
                        child: ProfileCardLeft(editable: false, theme: theme),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // 2ページ目
          LayoutBuilder(
            builder: (context, constraints) {
              final scale = constraints.maxWidth / 360;

              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: SizedBox(
                    width: constraints.maxWidth,
                    child: Center(
                      child: Transform.scale(
                        scale: scale < 1 ? scale : 1,
                        child: ProfileCardRight(editable: false, theme: theme),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
