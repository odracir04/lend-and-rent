import 'package:app_prototype/database/chats.dart';
import 'package:app_prototype/widgets/chat/chat_app_bar.dart';
import 'package:app_prototype/widgets/chat/message_list.dart';
import 'package:app_prototype/widgets/chat/message_write_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../database/users.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.changeTheme, required this.darkTheme, required this.receiverEmail, required this.db,
            required this.userEmail});

  final String userEmail;
  final String receiverEmail;
  final FirebaseFirestore db;
  final VoidCallback changeTheme;
  final bool darkTheme;

  @override
  State<StatefulWidget> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  late Future<List<DocumentSnapshot>> messages;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    messages = getChatMessages(widget.db, widget.userEmail, widget.receiverEmail);
  }
  
  void _onPressed() {
    setState(() {
      messages = getChatMessages(widget.db, widget.userEmail, widget.receiverEmail);
      writeMessage(widget.db, widget.userEmail, widget.receiverEmail, controller.text);
      controller.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getReceiverName(widget.receiverEmail), getReceiverLocation(widget.receiverEmail),getPictureUrl(FirebaseFirestore.instance, widget.receiverEmail)]),
        builder: (builder, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else {
            List<String?> data = snapshot.data ?? [];
            return Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: ChatAppBar(changeTheme: widget.changeTheme, darkTheme: widget.darkTheme, userName: data[0] ?? "", userLocation: data[1] ?? "", visitingEmail: widget.receiverEmail, userPicture: data[2] ?? "assets/images/profile.png"),
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