import 'package:app_prototype/database/users.dart';
import 'package:app_prototype/widgets/users/user_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../pages/chat_page.dart';

class ChatListItem extends StatefulWidget {

  ChatListItem({super.key, required this.changeTheme , required this.darkTheme, required this.receiverEmail,
                required this.db, required this.auth, required this.storage});

  final String receiverEmail;
  final VoidCallback changeTheme;
  final bool darkTheme;
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  @override
  State<StatefulWidget> createState() => ChatListItemState();

}

class ChatListItemState extends State<ChatListItem> {
  String? receiverName;
  String? userPicture;

  Future<void> setUserData() async {
    receiverName = await (getReceiverName(widget.db, widget.receiverEmail));
    userPicture = await (getPictureUrl(widget.db, widget.receiverEmail));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: setUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else {
            return ListTile(
              trailing: const Icon(Icons.send),
              leading: UserIcon(userPicture: userPicture!),
              title: Text(receiverName!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context)
                  => ChatPage(
                      auth: widget.auth,
                      storage: widget.storage,
                      changeTheme: widget.changeTheme,
                      darkTheme : widget.darkTheme,
                      receiverEmail: widget.receiverEmail,
                      db: widget.db,
                      userEmail: widget.auth.currentUser!.email ?? ""
                  )));},
            );
          }
        });
  }
}