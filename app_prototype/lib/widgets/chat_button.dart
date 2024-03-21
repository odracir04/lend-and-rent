import 'package:flutter/material.dart';

import '../pages/chat_page.dart';

class ChatButton extends StatefulWidget {
  const ChatButton({super.key});

  @override
  State<StatefulWidget> createState() => ChatButtonState();
}

class ChatButtonState extends State<ChatButton> {

  void _onPressed() {
    setState(() {
      Navigator.push(context, MaterialPageRoute
        (builder: (context) { return const ChatPage(); }));
    });
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: _onPressed, child: const Text("Chat"));
  }
}