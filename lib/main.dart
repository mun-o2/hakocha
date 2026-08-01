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
import 'package:firebase_core/firebase_core.dart';
import 'package:hakocha/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const HakochaApp());
}

class HakochaApp extends StatelessWidget {
  const HakochaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExchangeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
  Key _topScreenKey = UniqueKey();

  List<Widget> get _screens => <Widget>[
    TopScreen(key: _topScreenKey),

    ExchangeScreen(
      onOpenProfile: () {
        setState(() {
          _selectedTab = AppTab.profile;
        });
      },
    ),

    const ProfileScreen(),
  ];

  void _onTabSelected(int index) {
    final selectedTab = AppTab.values[index];

    setState(() {
      if (selectedTab == AppTab.home) {
        // ホームを押したらTopScreenを初期状態に戻す
        _topScreenKey = UniqueKey();
      }

      _selectedTab = selectedTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _screens[_selectedTab.index],
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _selectedTab.index,
        onTap: _onTabSelected,
      ),
    );
  }
}
