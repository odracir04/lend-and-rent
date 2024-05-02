import 'package:app_prototype/widgets/chat/message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  MessageList({super.key, required this.messages, required this.userEmail});

  final String userEmail;
  late Future<List<DocumentSnapshot>> messages;

  @override
  State<StatefulWidget> createState() => MessageListState();
}

class MessageListState extends State<MessageList> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.messages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else if (snapshot.hasError) {
            return Text("ERROR: ${snapshot.error}");
          }
          else {
            List<DocumentSnapshot> messages = snapshot.data ?? [];
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
        }
    );
  }
}