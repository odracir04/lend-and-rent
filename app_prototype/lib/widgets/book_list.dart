import 'package:flutter/material.dart';
import '../database/books.dart';
import '../pages/book_page.dart';
import 'book_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  State<StatefulWidget> createState() => BookListState();
}

class BookListState extends State<BookList> {

  late Future<List<DocumentSnapshot>> books;

  void _onTap() {
    setState(() {
      Navigator.push(context, MaterialPageRoute
        (builder: (context) => const BookPage()));
    });
  }

  @override
  void initState() {
    super.initState();
    books = getBooks(5);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: books,
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
                return GestureDetector(
                  onTap: _onTap,
                  child: BookCard(bookName: "${bookData['title']}",
                      authorName: "${bookData['author']}"),
                );
              },
            ));
          }
        }
    );
  }
}
