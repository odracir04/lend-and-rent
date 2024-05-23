import 'package:app_prototype/database/books.dart';
import 'package:app_prototype/pages/search_page.dart';
import 'package:app_prototype/widgets/books/book_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class BookListPage extends StatefulWidget {
  BookListPage({super.key, required this.changeTheme, required this.darkTheme,
                required this.db, required this.auth, required this.storage});

  final VoidCallback changeTheme;
  bool darkTheme;
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  @override
  State<StatefulWidget> createState() => BookListPageState();
}

class BookListPageState extends State<BookListPage> {

  late Future<List<DocumentSnapshot>> books;

  @override
  void initState() {
    super.initState();
    books = getBooks(widget.db, 20);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
          onRefresh: () {
            setState(() {
              books = getBooks(widget.db, 20);
            });
            return Future<void>.delayed(const Duration(seconds: 0));
          },
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 60,
                  left: 25,
                  right: 25,
                  bottom: 80
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Flexible(
                            child: SearchBar(
                              keyboardType: TextInputType.none,
                              padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                              leading: const Icon(Icons.filter_list),
                              trailing: const [Icon(Icons.search)],
                              hintText: "Search for books here...",
                              onTap: () {Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => SearchPage(
                                    darkTheme: widget.darkTheme, changeTheme: widget.changeTheme, db: widget.db,
                                    auth: widget.auth, storage: widget.storage,)));},
                            )
                        ),
                        IconButton(
                            key: const Key("dark_mode_button"),
                            onPressed: widget.changeTheme
                            , icon: Icon(widget.darkTheme ? Icons.light_mode : Icons.dark_mode))
                      ],
                    ),
                  ),
                  BookList(books: books, darkTheme: widget.darkTheme, changeTheme: widget.changeTheme,
                    db: widget.db, auth: widget.auth, storage: widget.storage,),
                ],
              )
          ),
        )
    );
  }
}