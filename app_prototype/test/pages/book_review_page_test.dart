import 'package:app_prototype/pages/book_reviews_page.dart';
import 'package:app_prototype/pages/review_page.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
  MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth(mockUser: MockUser(email: "test@email.com"));

  final book = {
    "author": "Jack Smith",
    "title": "An Amazing Saga",
    "title_lowercase": "an amazing saga",
    "location": "Paranhos, Porto",
    "imagePath": "assets/images/book.jpg",
    "genres": ["Action", "Adventure"],
    "renter": "test@email.com"
  };

  setUpAll(() async {
    await fakeFirebaseFirestore.collection('books').add(book);

    await fakeFirebaseFirestore.collection('users').add(
        {
          "display_email": false,
          "email": "test@email.com",
          "location": "Trofa",
          "first_name": "Paulo",
          "last_name": "Carvalhal",
          "profile_url":"assets/images/profile.png"
        }
    );

    await fakeFirebaseFirestore.collection('bookreviews').add({
      "book": "An Amazing Saga",
      "review_stars": 2,
      "review_email": "test@email.com",
      "text": "Bad read!"
    });
  });

  testWidgets("Book review layout test", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BookReviewsPage(
        auth: mockFirebaseAuth, db: fakeFirebaseFirestore, darkTheme: true,
        changeTheme: () {}, book: book['title'] as String,
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsOneWidget);
  });

  testWidgets("Move to write review page test", (WidgetTester tester) async {
    mockFirebaseAuth.signInWithEmailAndPassword(email: "test@email.com", password: "password");
    await tester.pumpWidget(MaterialApp(
      home: BookReviewsPage(
        auth: mockFirebaseAuth, db: fakeFirebaseFirestore, darkTheme: true,
        changeTheme: () {}, book: book['title'] as String,
      ),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();

    expect(find.byType(Review), findsOneWidget);
  });
}