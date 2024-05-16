import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_prototype/login/recover_password.dart'; // Update with the correct path


void main() {
  testWidgets('Change to login page on goBack button tap', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: RecoverPassword()
      ),
    );
    expect(find.byType(RecoverPassword), findsOneWidget);

    expect(find.byKey(const Key('goBackButton')), findsOneWidget);
  });

}

