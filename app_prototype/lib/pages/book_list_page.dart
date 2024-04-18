import 'package:app_prototype/database/books.dart';
import 'package:app_prototype/pages/search_page.dart';
import 'package:app_prototype/widgets/books/book_list.dart';
import 'package:app_prototype/widgets/filter_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class BookListPage extends StatefulWidget {
  BookListPage({super.key, required this.changeTheme, required this.darkTheme});

  final VoidCallback changeTheme;
  bool darkTheme;

  @override
  State<StatefulWidget> createState() => BookListPageState();
}

class BookListPageState extends State<BookListPage> {

  late Future<List<DocumentSnapshot>> books;

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
              margin: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Flexible(
                      child: SearchBar(
                        //keyboardType: TextInputType.none,
                        padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                        leading: const Icon(Icons.filter_list),
                        trailing: [const Icon(Icons.search)],
                        hintText: "Search for books here...",
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));},
                      )
                  ),
                  IconButton(onPressed: widget.changeTheme
                      , icon: Icon(widget.darkTheme ? Icons.light_mode : Icons.dark_mode))
                ],
              ),
            ),
            const FilterBar(),
            BookList(books: books,),
          ],
        )
    );
  }
}