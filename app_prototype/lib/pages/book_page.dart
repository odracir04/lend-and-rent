import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Column(
        children: [
          Text("Book Cover image"),
          Text("Remaining Information..."),
        ],
      )),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }

}