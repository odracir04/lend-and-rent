import 'package:flutter/material.dart';
import '../../database/books.dart';
import 'book_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  State<StatefulWidget> createState() => BookListState();
}

class BookListState extends State<BookList> {

  late Future<List<DocumentSnapshot>> books;

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
                  onTap: null,
                  child: BookCard(bookName: "${bookData['title']}",
                      authorName: "${bookData['author']}",
                      imagePath: "${bookData['imagePath']}",
                      location: "${bookData['location']}",),
                );
              },
            ));
          }
        }
    );
  }
}
