import 'package:app_prototype/database/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final fakeFirestore = FakeFirebaseFirestore();

  setUpAll(() async {
    await fakeFirestore.collection('chats').add(
      {
        "datetime": DateTime.fromMillisecondsSinceEpoch(1000),
        "receiver": "email@example.org",
        "sender": "test@example.org",
        "text": "This is a test message!"
      }
    );
    await fakeFirestore.collection('chats').add(
        {
          "datetime": DateTime.fromMillisecondsSinceEpoch(2000),
          "receiver": "test@example.org",
          "sender": "email@example.org",
          "text": "This is a second test message!"
        }
    );
    await fakeFirestore.collection('chats').add(
        {
          "datetime": DateTime.fromMillisecondsSinceEpoch(3000),
          "receiver": "alternative@example.org",
          "sender": "test@example.org",
          "text": "This is a third test message!"
        }
    );
  });

  test("Get Chats", () async {
    Set<String> chats = await getChats(fakeFirestore, "test@example.org");
    expect(chats.length, 2);

    chats = await getChats(fakeFirestore, "alternative@example.org");
    expect(chats.length, 1);
    expect(chats.first, "test@example.org");

    chats = await getChats(fakeFirestore, "notauser@example.org");
    expect(chats.length, 0);
  });

  test("Write Message", () async {
    writeMessage(fakeFirestore, "nouser@example.org",
                  "user@example.org", "Test message 4!");

    QuerySnapshot messages = await fakeFirestore.collection('chats').
        where("sender", isEqualTo: "nouser@example.org").get();

    expect(messages.docs.length, 1);
    expect(messages.docs.first['receiver'], "user@example.org");
    expect(messages.docs.first['text'], "Test message 4!");
  });
}