import 'package:app_prototype/widgets/chat/message_write_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Message Write Bar structure", (WidgetTester tester) async {
    void testPress() {};
    TextEditingController testController = TextEditingController();
    await tester.pumpWidget(MaterialApp(home:
    Scaffold(body: MessageWriteBar(onPressed: testPress, controller: testController),)));

    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(tester.widget<TextField>(find.byType(TextField)).controller, testController);
  });
}