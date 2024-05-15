import 'package:flutter/material.dart';
import 'book_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookList extends StatefulWidget {
  BookList({super.key, required this.changeTheme, required this.darkTheme, required this.books});
  late Future<List<DocumentSnapshot>> books;
  final VoidCallback changeTheme;
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
                return BookCard(changeTheme: widget.changeTheme, darkTheme: widget.darkTheme,bookName: "${bookData['title']}",
                      authorName: "${bookData['author']}",
                      imagePath: "${bookData['imagePath']}",
                      location: "${bookData['location']}",
                      renter: "${bookData['renter']}");
              },
            ));
          }
        }
    );
  }
}
