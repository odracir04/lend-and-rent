import 'package:app_prototype/widgets/book_profile.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';
import '../widgets/user_list.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          const BookProfile(),
          const Text("Users renting this book"),
          UserList(),
        ],
      )),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }

}