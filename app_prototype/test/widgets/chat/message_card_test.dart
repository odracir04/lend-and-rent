import 'package:app_prototype/widgets/chat/message_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Message Card structure", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home:
    MessageCard(sender: true, text: "test message")));

    expect(find.byType(Card), findsOneWidget);
    expect(tester.widget<Card>(find.byType(Card)).color, Colors.black54);
    expect(find.text("test message"), findsOneWidget);
    expect(tester.widget<Text>(find.text("test message")).style?.color, Colors.white);
  });
}