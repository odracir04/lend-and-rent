import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

void populateDB() {
  FirebaseFirestore db = FirebaseFirestore.instance;
  for (int i = 1; i < 20; i++) {
    final book = {
      "author": "Jack Smith",
      "title": "The Amazing Saga Vol.$i",
      "title_lowercase": "the amazing saga vol.$i",
      "location": "Paranhos, Porto",
      "imagePath": "assets/images/book.jpg"
    };
    db.collection('books').doc("book$i").set(book);
  }
  Map<String, String> book = {
    "author": "Jack Smith",
    "title": "An Amazing Saga",
    "title_lowercase": "an amazing saga",
    "location": "Paranhos, Porto",
    "imagePath": "assets/images/book.jpg"
  };
  db.collection('books').doc("book20").set(book);
  book = {
    "author": "Jack Smith",
    "title": "Very Amazing Saga",
    "title_lowercase": "very amazing saga",
    "location": "Paranhos, Porto",
    "imagePath": "assets/images/book.jpg"
  };
  db.collection('books').doc("book21").set(book);
}

Future<List<DocumentSnapshot>> getBooks(int n) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  QuerySnapshot books = await db.collection('books').limit(n).get();
  List<DocumentSnapshot> result = [];
  for (DocumentSnapshot book in books.docs) {
    result.add(book);
  }
  return result;
}

Future<List<DocumentSnapshot>> getBooksSearch(String string) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  string =  string.toLowerCase();
  QuerySnapshot books = await db.collection('books')
      .where('title_lowercase', isGreaterThanOrEqualTo: string).where('title_lowercase', isLessThanOrEqualTo: "$string\uf7ff").get();
  List<DocumentSnapshot> result = [];
  for (DocumentSnapshot book in books.docs) {
    result.add(book);
  }
  return result;
}

Future<List<DocumentSnapshot>> getBooksSearchGenre(String string) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  QuerySnapshot books = await db.collection('books')
      .where('genres', arrayContains: string).get();
  List<DocumentSnapshot> result = [];
  for (DocumentSnapshot book in books.docs) {
    result.add(book);
  }
  return result;
}

Future<List<DocumentSnapshot>> getBooksSearchAuthor(String string) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  QuerySnapshot books = await db.collection('books').where('author', isEqualTo: string).get();
  List<DocumentSnapshot> result = [];
  for (DocumentSnapshot book in books.docs) {
    result.add(book);
  }
  return result;
}

Future<List<DocumentSnapshot>> getBooksSearchQueryGenre(String query, String genre) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  query =  query.toLowerCase();
  QuerySnapshot books = await db.collection('books')
      .where('title_lowercase', isGreaterThanOrEqualTo: query).where('title_lowercase', isLessThanOrEqualTo: "$query\uf7ff")
      .where('genres', arrayContains: genre).get();
  List<DocumentSnapshot> result = [];
  for (DocumentSnapshot book in books.docs) {
    result.add(book);
  }
  return result;
}

Future<List<DocumentSnapshot>> getBooksSearchQueryAuthor(String query, String author) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  query =  query.toLowerCase();
  QuerySnapshot books = await db.collection('books')
      .where('title_lowercase', isGreaterThanOrEqualTo: query).where('title_lowercase', isLessThanOrEqualTo: "$query\uf7ff")
      .where('author', isEqualTo: author).get();
  List<DocumentSnapshot> result = [];
  for (DocumentSnapshot book in books.docs) {
    result.add(book);
  }
  return result;
}

Future<List<DocumentSnapshot>> getBooksSearchGenreAuthor(String genre, String author) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  QuerySnapshot books = await db.collection('books')
      .where('genres', arrayContains: genre).where('author', isEqualTo: author).get();
  List<DocumentSnapshot> result = [];
  for (DocumentSnapshot book in books.docs) {
    result.add(book);
  }
  return result;
}

Future<List<DocumentSnapshot>> getBooksSearchAll(String query, String genre, String author) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  query =  query.toLowerCase();
  QuerySnapshot books = await db.collection('books')
      .where('title_lowercase', isGreaterThanOrEqualTo: query).where('title_lowercase', isLessThanOrEqualTo: "$query\uf7ff")
      .where('genres', arrayContains: genre).where('author', isEqualTo: author).get();
  List<DocumentSnapshot> result = [];
  for (DocumentSnapshot book in books.docs) {
    result.add(book);
  }
  return result;
}

Future<void> addBook(FirebaseStorage storage, FirebaseFirestore db, String pictureUrl, String? email, String author, String title, String location, List<String> genresSelected) async {
  Reference ref = storage.ref().child('books/${DateTime.now()}.jpg');
  UploadTask uploadTask = ref.putFile(File(pictureUrl));
  await uploadTask.whenComplete(() async {
    String url = await ref.getDownloadURL();
    final book = {
      "user": email,
      "author": author,
      "title": title,
      "title_lowercase": title.toLowerCase(),
      "location": location,
      "imagePath": url,
      "genres": genresSelected,
    };
    db.collection('books').doc().set(book);
  });
}
