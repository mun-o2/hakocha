import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hakocha/constants/app_strings.dart';
import 'package:hakocha/models/app_tab.dart';
import 'package:hakocha/providers/exchange_provider.dart';
import 'package:hakocha/screens/exchange_screen.dart';
import 'package:hakocha/screens/profile_screen.dart';
import 'package:hakocha/screens/splash_screen.dart';
import 'package:hakocha/screens/onboarding_screen.dart';
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
  final SignedInResolver? resolveSignedIn;

  const HakochaApp({super.key, this.resolveSignedIn});

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
        home: SplashScreen(resolveSignedIn: resolveSignedIn),
        routes: {
          '/onboarding': (context) => const OnboardingScreen(),
          '/home': (context) {
            final argument = ModalRoute.of(context)?.settings.arguments;
            return _HomeScreen(
              initialTab: argument is AppTab ? argument : AppTab.home,
            );
          },
        },
      ),
    );
  }
}

/// ホーム画面
class _HomeScreen extends StatefulWidget {
  final AppTab initialTab;

  const _HomeScreen({this.initialTab = AppTab.home});

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  late AppTab _selectedTab;

  Key _topScreenKey = UniqueKey();
  Key _profileScreenKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
  }

  List<Widget> get _screens => <Widget>[
    TopScreen(key: _topScreenKey),

    ExchangeScreen(
      onOpenProfile: () {
        setState(() {
          _profileScreenKey = UniqueKey();
          _selectedTab = AppTab.profile;
        });
      },
    ),

    ProfileScreen(key: _profileScreenKey),
  ];

  void _onTabSelected(int index) {
    final selectedTab = AppTab.values[index];

    setState(() {
      if (selectedTab == AppTab.home) {
        _topScreenKey = UniqueKey();
      }

      if (selectedTab == AppTab.profile) {
        _profileScreenKey = UniqueKey();
      }

      _selectedTab = selectedTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          final offset = Tween<Offset>(
            begin: const Offset(0.035, 0),
            end: Offset.zero,
          ).animate(animation);
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(position: offset, child: child),
          );
        },
        child: KeyedSubtree(
          key: ValueKey(_selectedTab),
          child: _screens[_selectedTab.index],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _selectedTab.index,
        onTap: _onTabSelected,
      ),
    );
  }
}
