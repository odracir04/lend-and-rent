import 'package:app_prototype/widgets/book_list.dart';
import 'package:app_prototype/widgets/user_icon.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Column(
      children: [
        Row(
          children: [
            UserIcon(),
            Text("Username")
          ],
        ),
        Text("Books for Rent",
          style: TextStyle(fontWeight: FontWeight.w700),
          ),
        BookList()
      ],
    ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1,),
    );
  }

}