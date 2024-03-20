import 'package:flutter/material.dart';

import 'book_card.dart';

class BookList extends StatelessWidget {
  const BookList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: const [
        BookCard(bookName: "Book 1", authorName: "John Cleese"),
        BookCard(bookName: "Book 2", authorName: "Roger Waters"),
        BookCard(bookName: "Book 3", authorName: "Matthias Corvinus"),
      ],
    );
  }

}