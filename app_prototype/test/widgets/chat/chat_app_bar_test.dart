import 'package:app_prototype/widgets/chat/chat_app_bar.dart';
import 'package:app_prototype/widgets/users/user_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Chat App Bar structure", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home:
    ChatAppBar(userLocation: "Testland", userName: "TestUser",)));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(UserIcon), findsOneWidget);
    expect(find.text("Testland"), findsOneWidget);
    expect(find.text("TestUser"), findsOneWidget);
  });
}