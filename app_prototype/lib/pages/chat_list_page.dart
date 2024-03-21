import 'package:app_prototype/widgets/user_list.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Chats"),),
        body: UserList(),
        bottomNavigationBar: BottomNavBar(currentIndex: 2,),
    );
  }
}