import 'package:app_prototype/database/chats.dart';
import 'package:app_prototype/widgets/chat/message_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../database/users.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.userEmail});

  final String userEmail;

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {

  late Future<List<DocumentSnapshot>> messages;

  @override
  void initState() {
    super.initState();
    messages = getChatMessages(widget.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getName(widget.userEmail), getLocation(widget.userEmail),]),
        builder: (builder, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else {
            List<String?> data = snapshot.data ?? [];
            return Scaffold(
                appBar: AppBar(
                  title: Column(
                    children: [
                      Text(data[0] ?? ""),
                      Text(data[1] ?? ""),
                    ],
                  ),
                ),
                body:
                    Column(
                      children: [
                        MessageList(messages: messages, userEmail: widget.userEmail),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 100),
                          child: TextField(decoration: InputDecoration(
                              hintText: "Send a message",
                              border: OutlineInputBorder()
                          ),
                          ),
                        ),
                      ],
                    )
            );
          }
        });
  }
}