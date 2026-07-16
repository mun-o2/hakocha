import 'package:flutter/material.dart';
import 'package:hakocha/constants/app_strings.dart';
import 'package:hakocha/models/app_tab.dart';
import 'package:hakocha/screens/exchange_screen.dart';
import 'package:hakocha/screens/profile_screen.dart';
import 'package:hakocha/screens/top_screen.dart';
import 'package:hakocha/widgets/app_bottom_navigation.dart';

void main() {
  runApp(const HakochaApp());
}

class HakochaApp extends StatefulWidget {
  const HakochaApp({super.key});

  @override
  State<HakochaApp> createState() => _HakochaAppState();
}

class _HakochaAppState extends State<HakochaApp> {
  AppTab _selectedTab = AppTab.home;

  static const List<Widget> _screens = <Widget>[
    TopScreen(),
    ExchangeScreen(),
    ProfileScreen(),
  ];

  void _onTabSelected(AppTab tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text(_selectedTab.label)),
        body: _screens[_selectedTab.index],
        bottomNavigationBar: AppBottomNavigation(
          selectedTab: _selectedTab,
          onTabSelected: _onTabSelected,
        ),
      ),
    );
  }
}
