import 'package:app_prototype/widgets/user_icon.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key,
                required this.bookName, required this.authorName});

  final String bookName, authorName;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/book.jpg",
              fit: BoxFit.fill),
          Row(
            children: [
              const UserIcon(),
              Expanded(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(bookName, textAlign: TextAlign.left,),
                  Text(authorName),
                ],
              )),
              const Text("Location")
            ],
          )
        ],
      ),
      )
    );
  }
}