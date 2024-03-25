import 'package:app_prototype/widgets/books/book_list.dart';
import 'package:app_prototype/widgets/filter_bar.dart';
import 'package:app_prototype/widgets/search_bar.dart';
import 'package:flutter/material.dart';


class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          MySearchBar(),
          FilterBar(),
          BookList(),
      ],
    )
    );
  }
}