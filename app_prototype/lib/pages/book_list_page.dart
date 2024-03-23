import 'package:app_prototype/widgets/book_list.dart';
import 'package:app_prototype/widgets/filter_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBar(
            padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
            leading: const Icon(Icons.search),
            hintText: "Search for books here...",
          ),
          const FilterBar(),
          BookList(),
      ],
    ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0,),
    );
  }
}