import 'package:app_prototype/pages/chat_list_page.dart';
import 'package:app_prototype/widgets/chat/chat_list_item.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  
  final FakeFirebaseFirestore fakeFirestore = FakeFirebaseFirestore();
  final MockFirebaseAuth mockAuth = MockFirebaseAuth(mockUser: MockUser());
  final MockFirebaseStorage mockFirebaseStorage = MockFirebaseStorage();

  setUpAll(() async {
    await fakeFirestore.collection('users').add({
      "display_email": true,
      "email": "email@example.org",
      "location": "Porto",
      "first_name": "Rui",
      "last_name": "Pereira",
      "profile_url": "assets/images/profile.png"
    });

    await fakeFirestore.collection('users').add({
      "display_email": true,
      "email": "alternative@example.org",
      "location": "Porto",
      "first_name": "António",
      "last_name": "Pereira",
      "profile_url": "assets/images/profile.png"
    });

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

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(MaterialApp(
          home: ChatListPage(changeTheme: testChangeTheme
          , darkTheme: darkTheme, userEmail: "test@example.org",
          db: fakeFirestore, auth: mockAuth, storage: mockFirebaseStorage,)));
    });

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
        db: fakeFirestore,
        auth: mockAuth,
        storage: mockFirebaseStorage,
    ),));

    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ChatListItem), findsNothing);
    expect(find.byIcon(Icons.chat), findsOneWidget);
    expect(find.text("Chats"), findsOneWidget);
  });
}