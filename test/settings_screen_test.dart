import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hakocha/screens/settings/privacy_policy_screen.dart';
import 'package:hakocha/screens/settings/service_screen.dart';
import 'package:hakocha/screens/settings_screen.dart';

void main() {
  testWidgets('settings links open the policy screens without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: SettingsScreen(email: 'test@example.com')),
    );

    expect(find.text('test@example.com'), findsOneWidget);

    await tester.tap(find.text('プライバシーポリシー'));
    await tester.pumpAndSettle();
    expect(find.byType(PrivacyPolicyScreen), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_ios));
    await tester.pumpAndSettle();
    await tester.tap(find.text('利用規約'));
    await tester.pumpAndSettle();
    expect(find.byType(ServiceScreen), findsOneWidget);
  });

  testWidgets('logout signs out and clears the navigation history', (
    tester,
  ) async {
    var signedOut = false;

    await tester.pumpWidget(
      MaterialApp(
        home: SettingsScreen(
          email: 'test@example.com',
          onSignOut: () async {
            signedOut = true;
          },
        ),
        routes: {
          '/onboarding': (_) => const Scaffold(body: Text('onboarding')),
        },
      ),
    );

    await tester.ensureVisible(find.text('ログアウト'));
    await tester.tap(find.text('ログアウト'));
    await tester.pumpAndSettle();
    expect(find.text('ログアウトしますか？'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'ログアウト'));
    await tester.pumpAndSettle();

    expect(signedOut, isTrue);
    expect(find.text('onboarding'), findsOneWidget);
  });
}
