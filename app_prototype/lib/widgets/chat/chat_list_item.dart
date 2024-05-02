import 'package:app_prototype/database/users.dart';
import 'package:app_prototype/widgets/users/user_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../pages/chat_page.dart';

class ChatListItem extends StatefulWidget {
  ChatListItem({super.key, required this.receiverEmail});

  final String receiverEmail;

  @override
  State<StatefulWidget> createState() => ChatListItemState();

}

class ChatListItemState extends State<ChatListItem> {
  late Future<String?> receiverName;

  @override
  void initState() {
    super.initState();
    receiverName = getName(widget.receiverEmail);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: receiverName,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else {
            String name = snapshot.data ?? "";
            return ListTile(
              trailing: const Icon(Icons.send),
              leading: const UserIcon(),
              title: Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              onTap: () {Navigator.push(context,
                  MaterialPageRoute(builder: (context)
                  => ChatPage(
                      receiverEmail: widget.receiverEmail,
                      db: FirebaseFirestore.instance,
                      userEmail: FirebaseAuth.instance.currentUser!.email ?? ""
                  )));},
            );
          }
        });
  }
}