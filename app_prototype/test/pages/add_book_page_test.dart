import 'package:app_prototype/database/books.dart';
import 'package:app_prototype/navigation_bar.dart';
import 'package:app_prototype/pages/add_book_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final fakeFirestore = FakeFirebaseFirestore();

  setUpAll(() async {
    await fakeFirestore.collection('books').add({
      "user": "email@example.org",
      "author": "Jack Smith",
      "title": "The Amazing Saga Vol.1",
      "title_lowercase": "the amazing saga vol.1",
      "location": "Paranhos, Porto",
      "imagePath": "assets/images/book.jpg",
      "genres": ["Action", "Adventure"]
    });
  });

  testWidgets('Change to AddBookPage', (WidgetTester tester) async {
    bool darkTheme = false;
    void testChangeTheme() { darkTheme = !darkTheme; }
    List<Menu> destinations = [];
    await tester.pumpWidget(MaterialApp(
        home: MenuNavBarController(changeTheme: testChangeTheme, darkTheme: darkTheme, destinations: destinations)));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.byType(AddBookPage), findsOneWidget);
  });

  testWidgets('Add book button does nothing because fields are empty', (WidgetTester tester) async {
    bool darkTheme = false;
    await tester.pumpWidget(MaterialApp(
        home: AddBookPage(darkTheme: darkTheme,)));

    await tester.tap(find.text('Add book'));
    expect(find.byType(AddBookPage), findsOneWidget);
  });

  testWidgets('Adding book', (WidgetTester tester) async {
    Future<List<DocumentSnapshot>> futureBooks = getBooksSearch('The', fakeFirestore);
    List<DocumentSnapshot> books = await futureBooks;
    expect(books.length, 1);

    final book = {
      "user": 'email@example.org',
      "author": 'Jack Smith',
      "title": 'The Amazing Saga Vol.2',
      "title_lowercase": 'the amazing saga vol.2',
      "location": 'Porto',
      "imagePath": 'assets/images/book.jpg',
      "genres": ['Action', 'Adventure'],
    };
    addBook(fakeFirestore, book);

    futureBooks = getBooksSearch('The', fakeFirestore);
    books = await futureBooks;
    expect(books.length, 2);
  });
}