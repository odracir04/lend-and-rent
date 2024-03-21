import 'package:flutter/material.dart';

class BookProfile extends StatelessWidget {
  const BookProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Book image"),
        Text("Book name"),
        Text("Book author")
      ],
    );
  }

}