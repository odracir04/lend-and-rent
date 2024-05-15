import 'dart:math';

import 'package:app_prototype/database/books.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final fakeFirestore = FakeFirebaseFirestore();

  setUpAll(() async {
    await fakeFirestore.collection('books').add({
      "author": "Jack Smith",
      "title": "The Amazing Saga Vol.1",
      "title_lowercase": "the amazing saga vol.1",
      "location": "Paranhos, Porto",
      "imagePath": "assets/images/book.jpg",
      "genres": ["Action", "Adventure"],
      "renter": "test2@email.com"
    });

    await fakeFirestore.collection('books').add({
      "author": "José Saramago",
      "title": "The Amazing Saga Vol.2",
      "title_lowercase": "the amazing saga vol.2",
      "location": "Paranhos, Porto",
      "imagePath": "assets/images/book.jpg",
      "genres": ["Action"],
      "renter": "test1@email.com"
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

  testWidgets("Searching books by title", (WidgetTester tester) async {
    late Future<List<DocumentSnapshot>> futureBooks = getBooksSearch('The', fakeFirestore);
    List<DocumentSnapshot> books = await futureBooks;
    expect(books.length, 2);

    futureBooks = getBooksSearch('something', fakeFirestore);
    books = await futureBooks;
    expect(books.length, 0);
  });

  testWidgets("Searching books by genre", (WidgetTester tester) async {
    late Future<List<DocumentSnapshot>> futureBooks = getBooksSearchGenre('Action', fakeFirestore);
    List<DocumentSnapshot> books = await futureBooks;
    expect(books.length, 4);

    futureBooks = getBooksSearchGenre('Adventure', fakeFirestore);
    books = await futureBooks;
    expect(books.length, 3);

    futureBooks = getBooksSearchGenre('Fantasy', fakeFirestore);
    books = await futureBooks;
    expect(books.length, 0);
  });

  testWidgets("Searching books by author", (WidgetTester tester) async {
    late Future<List<DocumentSnapshot>> futureBooks = getBooksSearchAuthor('Jack Smith', fakeFirestore);
    List<DocumentSnapshot> books = await futureBooks;
    expect(books.length, 3);

    futureBooks = getBooksSearchGenre('something', fakeFirestore);
    books = await futureBooks;
    expect(books.length, 0);
  });

  testWidgets("Searching books by title and genre", (WidgetTester tester) async {
    late Future<List<DocumentSnapshot>> futureBooks = getBooksSearchQueryGenre('The', 'Adventure', fakeFirestore);
    List<DocumentSnapshot> books = await futureBooks;
    expect(books.length, 1);

    futureBooks = getBooksSearchQueryGenre('something', 'Adventure', fakeFirestore);
    books = await futureBooks;
    expect(books.length, 0);

    futureBooks = getBooksSearchQueryGenre('The', 'Fantasy', fakeFirestore);
    books = await futureBooks;
    expect(books.length, 0);
  });

  testWidgets("Searching books by title and author", (WidgetTester tester) async {
    late Future<List<DocumentSnapshot>> futureBooks = getBooksSearchQueryAuthor('The', 'Jack Smith', fakeFirestore);
    List<DocumentSnapshot> books = await futureBooks;
    expect(books.length, 1);

    futureBooks = getBooksSearchQueryAuthor('something', 'Jack Smith', fakeFirestore);
    books = await futureBooks;
    expect(books.length, 0);

    futureBooks = getBooksSearchQueryAuthor('The', 'something', fakeFirestore);
    books = await futureBooks;
    expect(books.length, 0);
  });

  testWidgets("Searching books by genre and author", (WidgetTester tester) async {
    late Future<List<DocumentSnapshot>> futureBooks = getBooksSearchGenreAuthor('Action', 'José Saramago', fakeFirestore);
    List<DocumentSnapshot> books = await futureBooks;
    expect(books.length, 1);

    futureBooks = getBooksSearchGenreAuthor('Adventure', 'José Saramago', fakeFirestore);
    books = await futureBooks;
    expect(books.length, 0);

    futureBooks = getBooksSearchQueryGenre('Action', 'something', fakeFirestore);
    books = await futureBooks;
    expect(books.length, 0);
  });

  testWidgets("Searching books by all parameters", (WidgetTester tester) async {
    late Future<List<DocumentSnapshot>> futureBooks = getBooksSearchAll('The', 'Action', 'Jack Smith', fakeFirestore);
    List<DocumentSnapshot> books = await futureBooks;
    expect(books.length, 1);

    futureBooks = getBooksSearchAll('The', 'Fantasy', 'Jack Smith', fakeFirestore);
    books = await futureBooks;
    expect(books.length, 0);

    futureBooks = getBooksSearchAll('something', 'Action', 'Jack Smith', fakeFirestore);
    books = await futureBooks;
    expect(books.length, 0);

    futureBooks = getBooksSearchAll('The', 'Action', 'something', fakeFirestore);
    books = await futureBooks;
    expect(books.length, 0);
  });

  testWidgets("Get books for user", (WidgetTester tester) async{
    late Future<List<DocumentSnapshot>> futureBooks = getBooksForUser(fakeFirestore, "test2@email.com");
    List<DocumentSnapshot> books = await futureBooks;
    expect(books.length,1);

    futureBooks = getBooksForUser(fakeFirestore, "test@email.com");
    books = await futureBooks;
    expect(books.length,2);
    
    futureBooks = getBooksForUser(fakeFirestore, "test1@email.com");
    books = await futureBooks;
    expect(books.length,1);
  });


}