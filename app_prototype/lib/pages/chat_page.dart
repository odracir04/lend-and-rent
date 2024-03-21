import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/images/profile.png"),
        title: const Text("User"),
      ),
      body:
        const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                  children:
                  [
                    Expanded(
                    child: TextField(
                    decoration: InputDecoration(
                      hintText: "Write a message...",
                    ),
                  )),
                    IconButton(onPressed: null, icon: Icon(Icons.send))
                  ]
            ))],
        ),
    bottomNavigationBar: BottomNavBar(currentIndex: 2,),
    );
  }

}