import 'package:app_prototype/widgets/chat/message_card.dart';
import 'package:flutter/material.dart';

import '../database/users.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.userEmail});

  final String userEmail;

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getName(widget.userEmail), getLocation(widget.userEmail)]),
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
                body: const Column(
                  children: [
                    MessageCard(sender: true, text: "Hello! How are you?"),
                    MessageCard(sender: false, text: "I'm doing good!"),
                  ],
                ),
            );
          }
        });
  }
}