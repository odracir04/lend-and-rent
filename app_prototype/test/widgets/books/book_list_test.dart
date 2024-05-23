import 'package:app_prototype/database/books.dart';
import 'package:app_prototype/widgets/books/book_card.dart';
import 'package:app_prototype/widgets/books/book_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  FakeFirebaseFirestore fakeFirestore = FakeFirebaseFirestore();
  MockFirebaseStorage mockFirebaseStorage = MockFirebaseStorage();
  MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();

  setUpAll(() async {
    await fakeFirestore.collection('users').add({
      "display_email": false,
      "email": "test@email.com",
      "location": "Trofa",
      "first_name": "Paulo",
      "last_name": "Carvalhal",
      "profile_url":"assets/images/profile.png"
    });

    await fakeFirestore.collection('books').add({
      "author": "Jack Smith",
      "title": "The Amazing Saga Vol.1",
      "title_lowercase": "the amazing saga vol.1",
      "location": "Paranhos, Porto",
      "imagePath": "assets/images/book.jpg",
      "genres": ["Action", "Adventure"],
      "renter": "test@email.com"
    });

    await fakeFirestore.collection('books').add({
      "author": "José Saramago",
      "title": "The Amazing Saga Vol.2",
      "title_lowercase": "the amazing saga vol.2",
      "location": "Paranhos, Porto",
      "imagePath": "assets/images/book.jpg",
      "genres": ["Action"],
      "renter": "test@email.com"
    });

    await fakeFirestore.collection('books').add({
      "author": "Jack Smith",
      "title": "An Amazing Saga",
      "title_lowercase": "an amazing saga",
      "location": "Paranhos, Porto",
      "imagePath": "assets/images/book.jpg",
      "genres": ["Action", "Adventure"],
      "renter": "test@email.com"
    });
    await fakeFirestore.collection('books').add({
      "author": "Jack Smith",
      "title": "An Amazing Saga",
      "title_lowercase": "an amazing saga",
      "location": "Paranhos, Porto",
      "imagePath": "assets/images/book.jpg",
      "genres": ["Action", "Adventure"],
      "renter": "test@email.com"
    });
  });

  testWidgets("Basic Book List", (WidgetTester tester) async {
    final books = getBooks(fakeFirestore, 20);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
            children: [BookList(
              db: fakeFirestore, auth: mockFirebaseAuth, darkTheme: false,
              storage: mockFirebaseStorage, changeTheme: () {}, books: books,
            )
            ]))));
    await tester.pumpAndSettle();

    expect(find.byType(BookCard), findsNWidgets(4));
  });
}