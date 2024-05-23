import 'package:app_prototype/login/sign_in_page.dart';
import 'package:app_prototype/main.dart';
import 'package:app_prototype/pages/book_list_page.dart';
import 'package:app_prototype/pages/edit_profile.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  final mockUser = MockUser(
      email: "email@example.org",
      displayName: "TestUser",
  );

  MockFirebaseAuth fakeAuth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);
  FakeFirebaseFirestore fakeFirestore = FakeFirebaseFirestore();
  MockFirebaseStorage mockFirebaseStorage = MockFirebaseStorage();

  setUpAll(() async {
    await fakeFirestore.collection('users').add(
        {
          "display_email": true,
          "email": "test@gmail.com",
          "location": "Porto",
          "first_name": "Rui",
          "last_name": "Bode",
          "profile_url": "assets/images/profile.png"
        });
    await fakeFirestore.collection('users').add(
        {
          "display_email": true,
          "email": "email@example.org",
          "location": "Trofa",
          "first_name": "Paulo",
          "last_name": "Carvalhal",
          "profile_url": "assets/images/profile.png"
        });
  });

  testWidgets("Delete user account test", (WidgetTester tester) async {
    const Key deleteButton = Key("delete_profile_button");
    fakeAuth.signInWithEmailAndPassword(email: "email@example.org", password: "password");

    await mockNetworkImagesFor(() =>
        tester.pumpWidget(MaterialApp(
            home: EditProfilePage(changeTheme: () {}, darkTheme: false,
                userEmail: "email@example.org", db: fakeFirestore,
                auth: fakeAuth, storage: mockFirebaseStorage,))));

    await tester.pumpAndSettle();
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -500));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(deleteButton));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);

    await tester.tap(find.text("Yes"));
    await tester.pump();

    final users = await fakeFirestore.collection('users').get();

    expect(users.size, 1);
  });

}