import 'package:app_prototype/database/chats.dart';
import 'package:app_prototype/widgets/chat/message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key, required this.receiverEmail, required this.userEmail,
                required this.db});

  final String userEmail, receiverEmail;
  final FirebaseFirestore db;

  @override
  State<StatefulWidget> createState() => MessageListState();
}

class MessageListState extends State<MessageList> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getChatMessages(widget.db, widget.userEmail, widget.receiverEmail),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            List<DocumentSnapshot> messages = snapshot.data!.docs ?? [];
            return Expanded(child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> messageData = messages[index].data() as Map<String, dynamic>;
                return MessageCard(sender: messageData['sender'] == widget.userEmail, text: messageData['text']);
              },
            ));
          }
        });
  }
}