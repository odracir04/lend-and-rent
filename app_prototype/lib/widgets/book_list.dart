import 'package:flutter/material.dart';

import '../pages/book_page.dart';
import 'book_card.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  State<StatefulWidget> createState() => BookListState();
}

class BookListState extends State<BookList> {
  void _onTap() {
    setState(() {
      Navigator.push(context, MaterialPageRoute
        (builder: (context) => const BookPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        GestureDetector(
          onTap: _onTap,
          child: const BookCard(bookName: "Book 1", authorName: "Jack K."),
        ),
        GestureDetector(
          onTap: _onTap,
          child: const BookCard(bookName: "Book 2", authorName: "Fyodor D."),
        ),
        GestureDetector(
          onTap: _onTap,
          child: const BookCard(bookName: "Book 3", authorName: "Sylvia P."),
        ),
      ],
    );
  }
}
