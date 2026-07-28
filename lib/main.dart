import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hakocha/constants/app_strings.dart';
import 'package:hakocha/models/app_tab.dart';
import 'package:hakocha/providers/exchange_provider.dart';
import 'package:hakocha/screens/exchange_screen.dart';
import 'package:hakocha/screens/profile_screen.dart';
import 'package:hakocha/screens/splash_screen.dart';
import 'package:hakocha/screens/top_screen.dart';
import 'package:hakocha/widgets/app_bottom_navigation_bar.dart';

void main() {
  runApp(const HakochaApp());
}

class HakochaApp extends StatelessWidget {
  const HakochaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExchangeProvider(),
      child: MaterialApp(
        title: AppStrings.appTitle,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        routes: {'/home': (context) => const _HomeScreen()},
      ),
    );
  }
}

/// ホーム画面
class _HomeScreen extends StatefulWidget {
  const _HomeScreen();

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  AppTab _selectedTab = AppTab.home;

  static const List<Widget> _screens = <Widget>[
    TopScreen(),
    ExchangeScreen(),
    ProfileScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedTab = AppTab.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_selectedTab.label)),
      body: _screens[_selectedTab.index],
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _selectedTab.index,
        onTap: _onTabSelected,
      ),
    );
  }
}
