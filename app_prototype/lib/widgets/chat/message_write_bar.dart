import 'package:flutter/material.dart';

class MessageWriteBar extends StatelessWidget {

  const MessageWriteBar({super.key, required this.onPressed,
  required this.controller});

  final VoidCallback onPressed;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                decoration: const InputDecoration(
                    hintText: "Send a message",
                    border: OutlineInputBorder()
                ),
                controller: controller,
              ),
          ),
          IconButton(onPressed: onPressed, icon: const Icon(Icons.send))
        ],
      )
    );
  }
}