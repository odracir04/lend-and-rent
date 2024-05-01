import 'package:app_prototype/pages/chat_list_page.dart';
import 'package:app_prototype/pages/chat_page.dart';
import 'package:app_prototype/widgets/chat/chat_app_bar.dart';
import 'package:app_prototype/widgets/chat/message_list.dart';
import 'package:app_prototype/widgets/chat/message_write_bar.dart';
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

  // can't run tests with filters in firebase???
}