import 'package:flutter/material.dart';
import 'book_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookList extends StatefulWidget {
  BookList({super.key, required this.books, required this.darkTheme});

  late Future<List<DocumentSnapshot>> books;
  final bool darkTheme;

  @override
  State<StatefulWidget> createState() => BookListState();
}

class BookListState extends State<BookList> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.books,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else if (snapshot.hasError) {
            return Text("ERROR: ${snapshot.error}");
          }
          else {
            List<DocumentSnapshot> books = snapshot.data ?? [];
            return Expanded(child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: books.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> bookData = books[index].data() as Map<String, dynamic>;
                bookData['id'] = books[index].id;
                return BookCard(book: bookData, darkTheme: widget.darkTheme,);
              },
            ));
          }
        }
    );
  }
}
