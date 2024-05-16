import 'package:app_prototype/database/chats.dart';
import 'package:app_prototype/widgets/chat/chat_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key, required this.changeTheme, required this.darkTheme, required this.userEmail, required this.db});

  final String userEmail;
  final FirebaseFirestore db;
  final VoidCallback changeTheme;
  final bool darkTheme;

  @override
  State<StatefulWidget> createState() => ChatListPageState();
}

class ChatListPageState extends State<ChatListPage> {

  late Future<Set<String>> chats;

  @override
  void initState() {
    super.initState();
    chats = getChats(widget.db, widget.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: chats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else if (snapshot.hasError) {
            return Text("ERROR: ${snapshot.error}");
          }
          else {
            List<String> messages = snapshot.data!.toList() ?? [];
            return Scaffold(
              appBar: AppBar(
                leading: const Icon(Icons.chat),
                title: const Text("Chats"),
              ),
              body: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8);
                },
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return ChatListItem(changeTheme : widget.changeTheme, darkTheme: widget.darkTheme, receiverEmail: messages[index], db: widget.db,);
                },
              ),
            );
          }
        }
    );
  }
}