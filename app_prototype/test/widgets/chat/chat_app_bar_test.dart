import 'package:app_prototype/pages/profile_page.dart';
import 'package:app_prototype/widgets/chat/chat_app_bar.dart';
import 'package:app_prototype/widgets/users/user_icon.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
  MockFirebaseStorage mockFirebaseStorage = MockFirebaseStorage();

  testWidgets("Chat App Bar structure", (WidgetTester tester) async {
    MockFirebaseAuth auth = MockFirebaseAuth(mockUser: MockUser());
    await mockNetworkImagesFor(() =>
    tester.pumpWidget(MaterialApp(home:
    ChatAppBar( visitingEmail: "pkwdk",userLocation: "Testland", auth: auth,
      userName: "TestUser", changeTheme: () {}, darkTheme: true,
      userPicture: "test.jpg", db: fakeFirebaseFirestore,
      storage: mockFirebaseStorage,))));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(UserIcon), findsOneWidget);
    expect(find.text("Testland"), findsOneWidget);
    expect(find.text("TestUser"), findsOneWidget);
  });
}