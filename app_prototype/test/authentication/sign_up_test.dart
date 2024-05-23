import 'package:app_prototype/login/sign_up_page.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_exceptions/mock_exceptions.dart';

void main() {
  testWidgets("Sign up test", (WidgetTester tester) async {
    MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
    FirebaseStorage firebaseStorage = MockFirebaseStorage();

    await tester.pumpWidget(MaterialApp(home: SignUpPage(
      auth: mockFirebaseAuth, db: fakeFirebaseFirestore, storage: firebaseStorage,
    )));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('first_name')), "John");
    await tester.enterText(find.byKey(const Key('last_name')), "Doe");
    await tester.enterText(find.byKey(const Key('email')), "john@example.org");
    
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -500));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('password')), 'password123');
    await tester.enterText(find.byKey(const Key('repeat_password')), 'password123');
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Your sign in was successful, please enjoy the app.'), findsOneWidget);
    expect(find.byType(SignUpPage), findsNothing);

    await tester.tap(find.text("Ok"));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets("Empty forms test", (WidgetTester tester) async {
    MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
    FirebaseStorage firebaseStorage = MockFirebaseStorage();

    await tester.pumpWidget(MaterialApp(home: SignUpPage(
      auth: mockFirebaseAuth, db: fakeFirebaseFirestore, storage: firebaseStorage,
    )));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -500));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text("Failed to sign up: One or more fields are empty."), findsOneWidget);

    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets("Different passwords test", (WidgetTester tester) async {
    MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
    FirebaseStorage firebaseStorage = MockFirebaseStorage();

    await tester.pumpWidget(MaterialApp(home: SignUpPage(
      auth: mockFirebaseAuth, db: fakeFirebaseFirestore, storage: firebaseStorage,
    )));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('first_name')), "John");
    await tester.enterText(find.byKey(const Key('last_name')), "Doe");
    await tester.enterText(find.byKey(const Key('email')), "john@example.org");

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -500));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('password')), 'password123');
    await tester.enterText(find.byKey(const Key('repeat_password')), 'wrongpassword');
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed to sign up: \'Password\' and \'Confirm Password\' fields do not match.'), findsOneWidget);

    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets("Didn't accept terms of service test", (WidgetTester tester) async {
    MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
    FirebaseStorage firebaseStorage = MockFirebaseStorage();

    await tester.pumpWidget(MaterialApp(home: SignUpPage(
      auth: mockFirebaseAuth, db: fakeFirebaseFirestore, storage: firebaseStorage,
    )));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('first_name')), "John");
    await tester.enterText(find.byKey(const Key('last_name')), "Doe");
    await tester.enterText(find.byKey(const Key('email')), "john@example.org");

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -500));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('password')), 'password123');
    await tester.enterText(find.byKey(const Key('repeat_password')), 'password123');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed to sign up: Please accept the Terms of Service and Privacy Policy.'), findsOneWidget);

    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets("Show password test", (WidgetTester tester) async {
    MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
    FirebaseStorage firebaseStorage = MockFirebaseStorage();

    await tester.pumpWidget(MaterialApp(home: SignUpPage(
      auth: mockFirebaseAuth, db: fakeFirebaseFirestore, storage: firebaseStorage,
    )));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -500));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.visibility), findsNWidgets(2));
    expect(find.byIcon(Icons.visibility_off), findsNothing);

    await tester.tap(find.byKey(const Key('show_password')));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    expect(find.byIcon(Icons.visibility), findsOneWidget);

    await tester.tap(find.byKey(const Key('show_check_password')));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.visibility_off), findsNWidgets(2));
    expect(find.byIcon(Icons.visibility), findsNothing);
  });

  testWidgets("User already exists", (WidgetTester tester) async {
    MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
    FirebaseStorage firebaseStorage = MockFirebaseStorage();

    fakeFirebaseFirestore.collection('users').add({
      'email': 'john@example.org',
      'first_name': 'John',
      'last_name': 'Doe',
      'location': "Porto",
      'display_email': false,
      'profile_url': "assets/images/profile.png",
    });

    await tester.pumpWidget(MaterialApp(home: SignUpPage(
      auth: mockFirebaseAuth, db: fakeFirebaseFirestore, storage: firebaseStorage,
    )));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('first_name')), "John");
    await tester.enterText(find.byKey(const Key('last_name')), "Doe");
    await tester.enterText(find.byKey(const Key('email')), "john@example.org");

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -500));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('password')), 'password123');
    await tester.enterText(find.byKey(const Key('repeat_password')), 'password123');
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);

    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets("Go back test", (WidgetTester tester) async {
    MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
    FirebaseStorage firebaseStorage = MockFirebaseStorage();

    await tester.pumpWidget(MaterialApp(home: SignUpPage(
      auth: mockFirebaseAuth, db: fakeFirebaseFirestore, storage: firebaseStorage,
    )));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.byType(SignUpPage), findsNothing);
  });

  testWidgets("Sign up error test", (WidgetTester tester) async {
    MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
    FirebaseStorage firebaseStorage = MockFirebaseStorage();

    whenCalling(Invocation.method(#createUserWithEmailAndPassword, null)).on(mockFirebaseAuth)
        .thenThrow(MockError());

    await tester.pumpWidget(MaterialApp(home: SignUpPage(
      auth: mockFirebaseAuth, db: fakeFirebaseFirestore, storage: firebaseStorage,
    )));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('first_name')), "John");
    await tester.enterText(find.byKey(const Key('last_name')), "Doe");
    await tester.enterText(find.byKey(const Key('email')), "john@example.org");

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -500));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('password')), 'password123');
    await tester.enterText(find.byKey(const Key('repeat_password')), 'password123');
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed to sign up: Email already in use.'), findsOneWidget);

    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
  });
}

class MockError implements Exception {
  MockError();

  @override
  int get hashCode {
    return 136609402;
  }

  @override
  bool operator ==(Object other) {
    return super.hashCode == other.hashCode;
  }
}