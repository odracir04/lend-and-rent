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
    return Expanded(child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: _onTap,
          child: BookCard(bookName: "Book ${index + 1}",
              authorName: "Author ${index + 1}"),
        );
      },
    ));
  }
}
