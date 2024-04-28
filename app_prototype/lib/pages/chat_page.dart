import 'package:app_prototype/database/chats.dart';
import 'package:app_prototype/widgets/chat/message_list.dart';
import 'package:app_prototype/widgets/chat/message_write_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../database/users.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.userEmail, required this.receiverEmail});

  final String userEmail;
  final String receiverEmail;

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {

  late Future<List<DocumentSnapshot>> messages;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    messages = getChatMessages(widget.userEmail, widget.receiverEmail);
  }
  
  void _onPressed() {
    setState(() {
      messages = getChatMessages(widget.userEmail, widget.receiverEmail);
      writeMessage(widget.userEmail, widget.receiverEmail, controller.text);
      controller.clear();
    });
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
                        MessageWriteBar(onPressed: _onPressed, controller: controller,)
                      ],
                    )
            );
          }
        });
  }
}