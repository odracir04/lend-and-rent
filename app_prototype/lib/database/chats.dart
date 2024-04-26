import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<DocumentSnapshot>> getChatMessages(String email) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  email = email.toLowerCase();


  QuerySnapshot messages = await db.collection('chats')
      .where(Filter.or(Filter('sender', isEqualTo: email), Filter('receiver', isEqualTo: email)))
      .orderBy('datetime').get();

  List<DocumentSnapshot> result = [];

  for (DocumentSnapshot message in messages.docs) {
    result.add(message);
  }

  return result;
}