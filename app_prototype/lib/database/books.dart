import 'package:cloud_firestore/cloud_firestore.dart';

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