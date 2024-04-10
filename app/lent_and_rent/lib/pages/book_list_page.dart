import '/database/books.dart';
import '/widgets/books/book_list.dart';
import '/widgets/filter_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class BookListPage extends StatefulWidget {
  const BookListPage({super.key, required this.changeTheme, required this.darkTheme});

  final VoidCallback changeTheme;
  final bool darkTheme;
  @override
  State<StatefulWidget> createState() => BookListPageState();
}

class BookListPageState extends State<BookListPage> {

  late Future<List<DocumentSnapshot>> books;
  late final VoidCallback changeTheme;
  late final bool darkTheme;

  @override
  void initState() {
    super.initState();
    changeTheme = widget.changeTheme;
    darkTheme = widget.darkTheme;
    books = getBooks(20);
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Flexible(
                            child: SearchBar(
                              padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                              leading: const Icon(Icons.search),
                              hintText: "Search for books here...",
                              onSubmitted: searchBooks,
                            )
                        ),
                        IconButton(onPressed: changeTheme
                            , icon: Icon(darkTheme ? Icons.light_mode : Icons.dark_mode))
                      ],
                    ),
                  ),
                  const FilterBar(),
                  BookList(books: books,),
                ],
              ))
    );
  }
}