import 'package:flutter/material.dart';

import '../pages/book_list_page.dart';
import '../pages/login_page.dart';
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
      switch (index){
        case 0:
          Navigator.push(context,
              MaterialPageRoute(builder:
                (BuildContext context) { return const BookListPage(); }));
        break;
        case 1:
          Navigator.push(context,
             MaterialPageRoute(builder:
                (BuildContext context) { return const UserPage(); }));
        break;
        case 2:
          Navigator.push(context,
              MaterialPageRoute(builder:
                  (BuildContext context) { return const LoginPage(); }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "Books"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout")
      ],
      onTap: _onTap,
      selectedItemColor: Colors.deepPurple,
      currentIndex: widget.currentIndex,
    );
  }
}