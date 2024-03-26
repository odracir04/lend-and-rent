import 'package:cloud_firestore/cloud_firestore.dart';

void populateDB() {
  FirebaseFirestore db = FirebaseFirestore.instance;
  for (int i = 1; i < 20; i++) {
    final book = {
      "author": "Jack Smith",
      "title": "The Amazing Saga Vol.$i",
      "location": "Paranhos, Porto",
      "imagePath": "assets/images/book.jpg"
    };
    db.collection('books').doc("book$i").set(book);
  }
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
  QuerySnapshot books = await db.collection('books')
      .where('title', isEqualTo: string).get();
  List<DocumentSnapshot> result = [];
  for (DocumentSnapshot book in books.docs) {
    result.add(book);
  }
  return result;
}