import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../database/books.dart';
import '../widgets/books/book_list.dart';
import '../widgets/filter_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {

  late Future<List<DocumentSnapshot>> books;

  void searchBooks(String string) {
    setState(() {
      books = getBooksSearch(string);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              child: Row(
                children: [
                  IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back),),
                  Flexible(
                      child: SearchBar(
                        padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                        leading: const Icon(Icons.search),
                        hintText: "Search for books here...",
                        onSubmitted: searchBooks,
                      )
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}