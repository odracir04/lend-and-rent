import 'package:app_prototype/pages/chat_list_page.dart';
import 'package:app_prototype/widgets/chat/chat_list_item.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
  final FakeFirebaseFirestore fakeFirestore = FakeFirebaseFirestore();
  setUpAll(() async {
    await fakeFirestore.collection('chats').add(
        {
          "datetime": DateTime.fromMillisecondsSinceEpoch(1000),
          "receiver": "email@example.org",
          "sender": "test@example.org",
          "text": "This is a test message!"
        }
    );
    await fakeFirestore.collection('chats').add(
        {
          "datetime": DateTime.fromMillisecondsSinceEpoch(2000),
          "receiver": "test@example.org",
          "sender": "email@example.org",
          "text": "This is a second test message!"
        }
    );
    await fakeFirestore.collection('chats').add(
        {
          "datetime": DateTime.fromMillisecondsSinceEpoch(3000),
          "receiver": "alternative@example.org",
          "sender": "test@example.org",
          "text": "This is a third test message!"
        }
    );
  });
  
  testWidgets('Chat List Page structure test', (WidgetTester tester) async {
    bool darkTheme = false;
    void testChangeTheme() { darkTheme = !darkTheme; }

    await tester.pumpWidget(MaterialApp(home: ChatListPage(
      darkTheme: darkTheme,
      changeTheme: testChangeTheme,
      userEmail: "test@example.org",
      db: fakeFirestore
    ),));

    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ChatListItem), findsNWidgets(2));
    expect(find.byIcon(Icons.chat), findsOneWidget);
    expect(find.text("Chats"), findsOneWidget);
  });

  testWidgets('No chats structure test', (WidgetTester tester) async {
    bool darkTheme = false;
    void testChangeTheme() { darkTheme = !darkTheme; }

    await tester.pumpWidget(MaterialApp(home: ChatListPage(
        darkTheme: darkTheme,
        changeTheme: testChangeTheme,
        userEmail: "nouser@example.org",
        db: fakeFirestore
    ),));

    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ChatListItem), findsNothing);
    expect(find.byIcon(Icons.chat), findsOneWidget);
    expect(find.text("Chats"), findsOneWidget);
  });
}