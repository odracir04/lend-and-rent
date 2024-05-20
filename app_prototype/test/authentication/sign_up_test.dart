import 'package:app_prototype/login/sign_up_page.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Sign up test", (WidgetTester tester) async {
    MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
    //FirebaseStorage firebaseStorage = FirebaseStorage.instance; mock

    /*await tester.pumpWidget(MaterialApp(home: SignUpPage(
      auth: mockFirebaseAuth, db: fakeFirebaseFirestore, storage: firebaseStorage,
    )));
    await tester.pumpAndSettle();*/

  });
}