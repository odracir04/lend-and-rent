import 'package:app_prototype/database/chats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_page.dart';

class ChatListPage extends StatefulWidget {
  ChatListPage({super.key});

  final String userEmail = FirebaseAuth.instance.currentUser!.email ?? "";

  @override
  State<StatefulWidget> createState() => ChatListPageState();
}

class ChatListPageState extends State<ChatListPage> {

  late Future<Set<String>> chats;

  @override void initState() {
    super.initState();
    chats = getChats(widget.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: chats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else if (snapshot.hasError) {
            return Text("ERROR: ${snapshot.error}");
          }
          else {
            List<String> messages = snapshot.data!.toList() ?? [];
            return Scaffold(
              appBar: AppBar(
                leading: const Icon(Icons.chat),
                title: const Text("Chats"),
              ),
              body: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(messages[index]),
                    onTap: () {Navigator.push(context,
                        MaterialPageRoute(builder: (context)
                        => ChatPage(receiverEmail: messages[index])));},
                  );
                },
              ),
            );
          }
        }
    );
  }
}