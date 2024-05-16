import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../database/books.dart';
import '../widgets/books/book_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.darkTheme});

  final bool darkTheme;

  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {

  late Future<List<DocumentSnapshot>> books;
  bool toggle = false;
  List<String> genres = ['All genres',
    'Action',
    'Adventure',
    'Comedy',
    'Crime',
    'Fantasy',
    'Horror',
    'Mystery',
    'Romance',
    'Sci-fi'
  ];
  String query = '';
  String genreSelected = 'All genres';
  String author = '';

  void searchBooks(String string) {
    setState(() {
      if (author.isEmpty) {
        if (genreSelected == 'All genres') {
          if (query.isNotEmpty) {
            books = getBooksSearch(query, FirebaseFirestore.instance);
          }
          else {
            books = getBooks(20);
          }
        }
        else if (query.isEmpty) {
          books = getBooksSearchGenre(genreSelected, FirebaseFirestore.instance);
        }
        else {
          books = getBooksSearchQueryGenre(query, genreSelected, FirebaseFirestore.instance);
        }
      }
      else if (genreSelected == 'All genres') {
        if (query.isEmpty) {
          books = getBooksSearchAuthor(author, FirebaseFirestore.instance);
        } else {
          books = getBooksSearchQueryAuthor(query, author, FirebaseFirestore.instance);
        }
      }
      else if (query.isEmpty) {
        books = getBooksSearchGenreAuthor(genreSelected, author, FirebaseFirestore.instance);
      }
      else {
        books = getBooksSearchAll(query, genreSelected, author, FirebaseFirestore.instance);
      }
    });
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  initState() {
    super.initState();
    books = Future<List<DocumentSnapshot>>.value([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
          onRefresh: () {
            setState(() {
              searchBooks('');
            });
            return Future<void>.delayed(const Duration(seconds: 0));
          },
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 60,
                  left: 25,
                  right: 25,
                  bottom: 0
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {Navigator.pop(context); FocusManager.instance.primaryFocus?.unfocus();},
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Flexible(
                            child: SearchBar(
                              //autoFocus: true,
                              leading: IconButton(onPressed: (){setState(() {
                                toggle = !toggle;
                              });}, icon: toggle ? const Icon(Icons.keyboard_arrow_up) : const Icon(Icons.filter_list),),
                              trailing: const [Icon(Icons.search)],
                              hintText: "Search for books here...",
                              onChanged: (String string){query = string;},
                              onSubmitted: searchBooks,
                            )
                        ),
                      ],
                    ),
                  ),
                  if (toggle) Container(
                    padding: const EdgeInsets.only(bottom: 25),
                    width: 0.90 * MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Filters',
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ]
                        ),
                        const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Genre',
                                style: TextStyle(fontSize: 20),
                              ),
                            ]
                        ),
                        DropdownMenu<String>(
                          width: 0.88 * MediaQuery.of(context).size.width,
                          initialSelection: genres.first,
                          onSelected: (String? value) {
                            genreSelected = value!;
                            searchBooks(value);
                          },
                          dropdownMenuEntries: genres.map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(value: value, label: value);
                          }).toList(),
                        ),
                        const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Author',
                                style: TextStyle(fontSize: 20),
                              ),
                            ]
                        ),
                        TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Any author'
                          ),
                          onChanged: (String string){author = string;},
                          onSubmitted: searchBooks,
                        )
                      ],
                    ),
                  ),
                  BookList(books: books, darkTheme: widget.darkTheme,),
                ],
              )
          ),
        )

    );
  }
}