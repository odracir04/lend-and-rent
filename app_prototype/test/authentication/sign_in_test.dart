import 'package:app_prototype/login/recover_password.dart';
import 'package:app_prototype/login/sign_in_page.dart';
import 'package:app_prototype/login/sign_up_page.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Sign in test", (WidgetTester tester) async {
    MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
    MockFirebaseStorage firebaseStorage = MockFirebaseStorage();

    bool signedIn = false;
    void testSignIn() {
      signedIn = true;
    }

    await tester.pumpWidget(MaterialApp(home:
    SignInPage(onSignIn: testSignIn, auth: mockFirebaseAuth,
    db: fakeFirebaseFirestore, storage: firebaseStorage,),));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Sign in"));
    await tester.pumpAndSettle();

    expect(signedIn, true);
  });

  testWidgets("Show password button test", (WidgetTester tester) async {
    MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
    MockFirebaseStorage firebaseStorage = MockFirebaseStorage();

    await tester.pumpWidget(MaterialApp(home:
    SignInPage(onSignIn: () {}, auth: mockFirebaseAuth,
      db: fakeFirebaseFirestore, storage: firebaseStorage,),));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.visibility), findsOneWidget);

    await tester.tap(find.byIcon(Icons.visibility));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
  });
  
  testWidgets("Recover password button test", (WidgetTester tester) async {
    MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
    MockFirebaseStorage firebaseStorage = MockFirebaseStorage();

    await tester.pumpWidget(MaterialApp(home:
    SignInPage(onSignIn: () {}, auth: mockFirebaseAuth,
      db: fakeFirebaseFirestore, storage: firebaseStorage,),));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -500));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Recover password"));
    await tester.pumpAndSettle();

    expect(find.byType(RecoverPassword), findsOneWidget);
  });

  testWidgets("Sign up button test", (WidgetTester tester) async {
    MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
    MockFirebaseStorage firebaseStorage = MockFirebaseStorage();

    await tester.pumpWidget(MaterialApp(home:
    SignInPage(onSignIn: () {}, auth: mockFirebaseAuth,
      db: fakeFirebaseFirestore, storage: firebaseStorage,),));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -500));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Sign up"));
    await tester.pumpAndSettle();

    expect(find.byType(SignUpPage), findsOneWidget);
  });
  
  testWidgets("Wrong credentials test", (WidgetTester tester) async {
    MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth(mockUser: MockUser(email: 'julie@example.org'));
    FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
    MockFirebaseStorage firebaseStorage = MockFirebaseStorage();

    await tester.pumpWidget(MaterialApp(home:
    SignInPage(onSignIn: () {}, auth: mockFirebaseAuth,
      db: fakeFirebaseFirestore, storage: firebaseStorage,),));
    await tester.pumpAndSettle();
    
    await tester.enterText(find.byKey(const Key('sign_in_email')), 'john@example.org');
    await tester.pumpAndSettle();

    await tester.tap(find.text("Sign in"));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
  });
}