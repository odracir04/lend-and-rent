import 'package:app_prototype/database/chats.dart';
import 'package:app_prototype/widgets/chat/chat_app_bar.dart';
import 'package:app_prototype/widgets/chat/message_list.dart';
import 'package:app_prototype/widgets/chat/message_write_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../database/users.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key, required this.receiverEmail});

  final String userEmail = FirebaseAuth.instance.currentUser!.email ?? "";
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
    messages = getChatMessages(FirebaseFirestore.instance, widget.userEmail, widget.receiverEmail);
  }
  
  void _onPressed() {
    setState(() {
      messages = getChatMessages(FirebaseFirestore.instance, widget.userEmail, widget.receiverEmail);
      writeMessage(FirebaseFirestore.instance, widget.userEmail, widget.receiverEmail, controller.text);
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getName(widget.receiverEmail), getLocation(widget.receiverEmail),]),
        builder: (builder, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else {
            List<String?> data = snapshot.data ?? [];
            return Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: ChatAppBar(userName: data[0] ?? "", userLocation: data[1] ?? "",),
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