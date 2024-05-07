import 'package:app_prototype/database/chats.dart';
import 'package:app_prototype/widgets/chat/chat_app_bar.dart';
import 'package:app_prototype/widgets/chat/message_list.dart';
import 'package:app_prototype/widgets/chat/message_write_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../database/users.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key, required this.receiverEmail, required this.db,
            required this.userEmail});

  final String userEmail;
  final String receiverEmail;
  final FirebaseFirestore db;

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  
  void _onPressed() {
    setState(() {
      writeMessage(widget.db, widget.userEmail, widget.receiverEmail, controller.text);
      controller.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getReceiverName(widget.receiverEmail), getReceiverLocation(widget.receiverEmail),]),
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
                        MessageList(receiverEmail: widget.receiverEmail, userEmail: widget.userEmail, db: widget.db,),
                        MessageWriteBar(onPressed: _onPressed, controller: controller,)
                      ],
                    )
            );
          }
        });
  }
}