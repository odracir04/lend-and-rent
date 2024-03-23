import 'package:app_prototype/widgets/book_list.dart';
import 'package:app_prototype/widgets/user_profile.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const UserProfile(),
        const Text("Previously Rented Books",
          style: TextStyle(fontWeight: FontWeight.w700),
          ),
        BookList()
      ],
    ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1,),
    );
  }

}