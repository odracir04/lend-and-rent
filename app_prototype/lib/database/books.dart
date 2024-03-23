import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<DocumentSnapshot>> getBooks(int n) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  QuerySnapshot books = await db.collection('books').limit(n).get();
  List<DocumentSnapshot> result = [];
  for (DocumentSnapshot book in books.docs) {
    result.add(book);
  }
  return result;
}