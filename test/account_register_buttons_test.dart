import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hakocha/widgets/onboarding/account_register_buttons.dart';

void main() {
  testWidgets('Google and existing-user buttons invoke authentication', (
    tester,
  ) async {
    var googleCalls = 0;
    var loginCalls = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AccountRegisterButtons(
            onApplePressed: () {},
            onGooglePressed: () => googleCalls++,
            onLoginPressed: () => loginCalls++,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Googleで続ける'));
    await tester.tap(find.text('ご利用中の方はこちら'));

    expect(googleCalls, 1);
    expect(loginCalls, 1);
  });

  testWidgets('authentication buttons are disabled while loading', (
    tester,
  ) async {
    var calls = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AccountRegisterButtons(
            canRegister: false,
            isLoading: true,
            onApplePressed: () => calls++,
            onGooglePressed: () => calls++,
            onLoginPressed: () => calls++,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(
      tester.widget<TextButton>(find.byType(TextButton)).onPressed,
      isNull,
    );
    expect(calls, 0);
  });
}
