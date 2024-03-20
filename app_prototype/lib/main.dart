import 'package:flutter/material.dart';

import 'pages/book_list_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BookListPage(),
      title: "Lend and Rent (Prototype)",
    );
  }

}