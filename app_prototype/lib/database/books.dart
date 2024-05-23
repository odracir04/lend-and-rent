import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<DocumentSnapshot>> getBooks(FirebaseFirestore db, int n) async {
  QuerySnapshot books = await db.collection('books').limit(n).get();
  List<DocumentSnapshot> result = [];
  for (DocumentSnapshot book in books.docs) {
    result.add(book);
  }
  return result;
}

Future<List<DocumentSnapshot>> getBooksForUser(FirebaseFirestore db,String email) async {
  QuerySnapshot books = await db.collection('books').where('renter', isEqualTo: email).get();
  List<DocumentSnapshot> my_books = [];
  for (DocumentSnapshot book in books.docs){
      my_books.add(book);
  }
  return my_books;
}

Future<List<DocumentSnapshot>> getBooksSearch(String string, FirebaseFirestore db) async {
  string =  string.toLowerCase();
  QuerySnapshot books = await db.collection('books')
      .where('title_lowercase', isGreaterThanOrEqualTo: string).where('title_lowercase', isLessThanOrEqualTo: "$string\uf7ff").get();
  List<DocumentSnapshot> result = [];
  for (DocumentSnapshot book in books.docs) {
    result.add(book);
  }
  return result;
}

Future<List<DocumentSnapshot>> getBooksSearchGenre(String string, FirebaseFirestore db) async {
  QuerySnapshot books = await db.collection('books')
      .where('genres', arrayContains: string).get();
  List<DocumentSnapshot> result = [];
  for (DocumentSnapshot book in books.docs) {
    result.add(book);
  }
  return result;
}

Future<List<DocumentSnapshot>> getBooksSearchAuthor(String string, FirebaseFirestore db) async {
  QuerySnapshot books = await db.collection('books').where('author', isEqualTo: string).get();
  List<DocumentSnapshot> result = [];
  for (DocumentSnapshot book in books.docs) {
    result.add(book);
  }
  return result;
}

Future<List<DocumentSnapshot>> getBooksSearchQueryGenre(String query, String genre, FirebaseFirestore db) async {
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

Future<List<DocumentSnapshot>> getBooksSearchQueryAuthor(String query, String author, FirebaseFirestore db) async {
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

Future<List<DocumentSnapshot>> getBooksSearchGenreAuthor(String genre, String author, FirebaseFirestore db) async {
  QuerySnapshot books = await db.collection('books')
      .where('genres', arrayContains: genre).where('author', isEqualTo: author).get();
  List<DocumentSnapshot> result = [];
  for (DocumentSnapshot book in books.docs) {
    result.add(book);
  }
  return result;
}

Future<List<DocumentSnapshot>> getBooksSearchAll(String query, String genre, String author, FirebaseFirestore db) async {
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

Future<void> addBook(FirebaseFirestore db, final book) async {
  db.collection('books').doc().set(book);
}

Future<void> deleteBook(FirebaseFirestore db, final book) async {
  db.collection('books').doc(book['id']).delete();
}

Future<List<DocumentSnapshot>> getBookReviews(FirebaseFirestore db, String title) async {
  QuerySnapshot reviews = await db.collection('bookreviews')
  .where('book', isEqualTo: title).get();
  List<DocumentSnapshot> result = [];
  for (DocumentSnapshot review in reviews.docs) {
    result.add(review);
  }
  return result;
}

Future<bool> writeBookReview(FirebaseFirestore db, String book, String email, double stars, String? text) async {
  try {
    db.collection('bookreviews').add({
      'book': book,
      'review_email': email,
      'review_stars': stars,
      'text': text
    });
  } catch (e) {
    return false;
  }

  return true;
}