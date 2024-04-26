import 'package:cloud_firestore/cloud_firestore.dart';

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
