import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {

  const MessageCard({super.key, required this.sender
                    , required this.text});

  final bool sender;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sender ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
          margin: const EdgeInsets.all(10),
          color: sender ? Colors.black54 : Colors.white24,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(text,
              style: TextStyle(
                  color: sender ? Colors.white : Colors.black
              ),
            ),
          )
      ),
    );
  }

}