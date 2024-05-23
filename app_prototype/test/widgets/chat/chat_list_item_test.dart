import 'package:app_prototype/pages/chat_list_page.dart';
import 'package:app_prototype/pages/chat_page.dart';
import 'package:app_prototype/widgets/chat/chat_list_item.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  FakeFirebaseFirestore db = FakeFirebaseFirestore();
  MockFirebaseStorage mockFirebaseStorage = MockFirebaseStorage();
  
  setUpAll(() async {
    await db.collection('users').add({
      "display_email": true,
      "email": "test@gmail.com",
      "location": "Porto",
      "first_name": "Rui",
      "last_name": "Pereira",
      "profile_url": "assets/images/profile.png"
    });

    await db.collection('users').add({
      "display_email": true,
      "email": "email@example.org",
      "location": "Porto",
      "first_name": "Toni",
      "last_name": "Pereira",
      "profile_url": "assets/images/profile.png"
    });

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
            darkTheme: true, userEmail: "email@example.org", storage: mockFirebaseStorage,)
      )));
    await tester.pump();

    expect(find.byType(ChatListItem), findsOneWidget);
  });
}