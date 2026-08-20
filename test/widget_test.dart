import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hakocha/main.dart';
import 'package:hakocha/screens/splash_screen.dart';

void main() {
  testWidgets('app starts with the splash screen', (tester) async {
    await tester.pumpWidget(HakochaApp(resolveSignedIn: () async => false));

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(FadeTransition), findsWidgets);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 2));
  });
}
