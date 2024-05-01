import 'package:app_prototype/pages/chat_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Chat Page structure test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ChatListPage(),));
  });
}