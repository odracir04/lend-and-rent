import 'package:app_prototype/database/books.dart';
import 'package:app_prototype/widgets/books/book_list.dart';
import 'package:app_prototype/widgets/filter_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<StatefulWidget> createState() => BookListPageState();
}

class BookListPageState extends State<BookListPage> {

  late Future<List<DocumentSnapshot>> books;

  void searchBooks(String string) {
    setState(() {
      if (string.isEmpty) {
        books = getBooks(20);
      }
      else {
        books = getBooksSearch(string);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    books = getBooks(20);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: SearchBar(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                  leading: const Icon(Icons.search),
                  hintText: "Search for books here...",
                  onSubmitted: searchBooks,
                )),
            const FilterBar(),
            BookList(books: books,),
          ],
        )
    );
  }
}