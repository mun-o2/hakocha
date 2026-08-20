import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hakocha/screens/splash_screen.dart';

void main() {
  Future<void> pumpSplash(WidgetTester tester, {required bool signedIn}) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SplashScreen(resolveSignedIn: () async => signedIn),
        routes: {
          '/home': (_) => const Scaffold(body: Text('home')),
          '/onboarding': (_) => const Scaffold(body: Text('onboarding')),
        },
      ),
    );
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
  }

  testWidgets('signed-in users skip onboarding', (tester) async {
    await pumpSplash(tester, signedIn: true);

    expect(find.text('home'), findsOneWidget);
    expect(find.text('onboarding'), findsNothing);
  });

  testWidgets('signed-out users see onboarding', (tester) async {
    await pumpSplash(tester, signedIn: false);

    expect(find.text('onboarding'), findsOneWidget);
    expect(find.text('home'), findsNothing);
  });
}
