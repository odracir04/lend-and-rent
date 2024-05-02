import 'package:app_prototype/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Display Sign In page if user is not logged in', (WidgetTester tester) async {

    await tester.pumpWidget(App());
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
}