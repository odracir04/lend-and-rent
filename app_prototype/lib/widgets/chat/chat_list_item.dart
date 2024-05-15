import 'package:app_prototype/database/users.dart';
import 'package:app_prototype/widgets/users/user_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../pages/chat_page.dart';

class ChatListItem extends StatefulWidget {
  const ChatListItem({super.key, required this.changeTheme , required this.darkTheme, required this.receiverEmail});

  final String receiverEmail;
  final VoidCallback changeTheme;
  final bool darkTheme;

  @override
  State<StatefulWidget> createState() => ChatListItemState();

}

class ChatListItemState extends State<ChatListItem> {
  String? receiverName;
  String? userPicture;

  Future<void> setUserData() async{
    receiverName = await (getReceiverName(widget.receiverEmail));
    userPicture = await (getPictureUrl(FirebaseFirestore.instance, widget.receiverEmail));

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
              onTap: () {Navigator.push(context,
                  MaterialPageRoute(builder: (context)
                  => ChatPage(
                      changeTheme: widget.changeTheme,
                      darkTheme : widget.darkTheme,
                      receiverEmail: widget.receiverEmail,
                      db: FirebaseFirestore.instance,
                      userEmail: FirebaseAuth.instance.currentUser!.email ?? ""
                  )));},
            );
          }
        });
  }
}