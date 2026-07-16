// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:hakocha/main.dart';

void main() {
  testWidgets('app shows bottom navigation tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const HakochaApp());

    expect(find.text('トップ画面'), findsOneWidget);
    expect(find.text('トップ'), findsNWidgets(2));
    expect(find.text('交換'), findsOneWidget);
    expect(find.text('プロフィール帳'), findsOneWidget);
  });
}
