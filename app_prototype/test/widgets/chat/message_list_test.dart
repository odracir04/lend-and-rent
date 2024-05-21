import 'package:app_prototype/widgets/chat/message_list.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();

  setUpAll(() async {
    fakeFirebaseFirestore.collection('chats').add({
      'datetime': DateTime.now(),
      'sender': 'email@example.org',
      'receiver': 'test@gmail.com',
      'text': 'message test'
    });
    fakeFirebaseFirestore.collection('chats').add({
      'datetime': DateTime.now(),
      'sender': 'test@gmail.com',
      'receiver': 'email@example.org',
      'text': 'message test2'
    });
    fakeFirebaseFirestore.collection('chats').add({
      'datetime': DateTime.now(),
      'sender': 'email@example.org',
      'receiver': 'test@gmail.com',
      'text': 'message test3'
    });
  });

  testWidgets("Message list test", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MessageList(
          receiverEmail: "email@example.org", userEmail: "test@gmail.com",
          db: fakeFirebaseFirestore)),
    );
    await tester.pump();

    expect(find.byType(Expanded), findsNWidgets(3));

    // FakeFirestore doesn't deal with OR filters
  });
}