import 'package:app_prototype/pages/chat_list_page.dart';
import 'package:app_prototype/pages/chat_page.dart';
import 'package:app_prototype/widgets/chat/chat_list_item.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  FakeFirebaseFirestore db = FakeFirebaseFirestore();
  
  setUpAll(() async {
    await db.collection('chats').add({
      'datetime': DateTime.now(),
      'receiver': 'email@example.org',
      'sender': 'test@gmail.com',
      'text': "Test message!"
    });
  });
  
  testWidgets("Chat list test", (WidgetTester tester) async {
    MockFirebaseAuth auth = MockFirebaseAuth(mockUser: MockUser());
    await mockNetworkImagesFor(() async => await tester.pumpWidget(MaterialApp(
          home: ChatListPage(auth: auth, db: db, changeTheme: () {},
            darkTheme: true, userEmail: "email@example.org",)
      )));
    await tester.pump();

    expect(find.byType(ChatListItem), findsOneWidget);
  });

  testWidgets("Open chat test", (WidgetTester tester) async {
    MockFirebaseAuth auth = MockFirebaseAuth(mockUser: MockUser());
    await mockNetworkImagesFor(() async => await tester.pumpWidget(MaterialApp(
        home: ChatListPage(auth: auth, db: db, changeTheme: () {},
          darkTheme: true, userEmail: "email@example.org",)
    )));
    await tester.pump();

    await tester.tap(find.byType(ChatListItem));
    await tester.pumpAndSettle();

    // can't mock images for following pages...
  });
}