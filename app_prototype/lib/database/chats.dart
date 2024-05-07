import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages(FirebaseFirestore db, String email1, String email2) {
  email1 = email1.toLowerCase();
  email2 = email2.toLowerCase();


  Stream<QuerySnapshot<Map<String, dynamic>>> messages = db.collection('chats')
      .where(
      Filter.or(
      Filter.and(Filter('sender', isEqualTo: email1), Filter('receiver', isEqualTo: email2)),
      Filter.and(Filter('sender', isEqualTo: email2), Filter('receiver', isEqualTo: email1))
      ))
      .orderBy('datetime').snapshots();

  return messages;
}

void writeMessage(FirebaseFirestore db, String sender, String receiver, String text) {
  db.collection('chats').add(
      { 'sender': sender,
        'receiver': receiver,
        'text': text,
        'datetime': Timestamp.now()
      });
}

Future<Set<String>> getChats(FirebaseFirestore db, String email) async {
  email = email.toLowerCase();
  
  QuerySnapshot chats = await db.collection('chats')
  .where('sender', isEqualTo: email).orderBy('datetime', descending: true).get();

  Set<String> result = {};
  
  for (DocumentSnapshot chat in chats.docs) {
    result.add(chat['receiver']);
  }

  chats = await db.collection('chats')
      .where('receiver', isEqualTo: email).get();

  for (DocumentSnapshot chat in chats.docs) {
    result.add(chat['sender']);
  }

  return result;
}