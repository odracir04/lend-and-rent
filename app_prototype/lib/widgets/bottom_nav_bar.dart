import 'package:flutter/material.dart';

import '../pages/book_list_page.dart';
import '../pages/user_page.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({super.key, required this.currentIndex});

  int currentIndex;

  @override
  State<StatefulWidget> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {

  void _onTap(int index) {
    setState((){
      if (index == 0) {
        Navigator.push(context,
            MaterialPageRoute(builder:
                (BuildContext context) { return const BookListPage(); }));
      }
      else {
        Navigator.push(context,
            MaterialPageRoute(builder:
                (BuildContext context) { return const UserPage(); }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "Books"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
      onTap: _onTap,
      selectedItemColor: Colors.deepPurple,
      currentIndex: widget.currentIndex,
    );
  }
}