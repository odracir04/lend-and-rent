import 'package:app_prototype/pages/chat_list_page.dart';
import 'package:flutter/material.dart';

import '../pages/book_list_page.dart';
import '../pages/chat_page.dart';
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
                  (BuildContext context) { return const ChatListPage(); }));
          break;
        case 3:
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
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "Books", backgroundColor: Colors.black),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile", backgroundColor: Colors.black),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats", backgroundColor: Colors.black),
        BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout", backgroundColor: Colors.black)
      ],
      onTap: _onTap,
      currentIndex: widget.currentIndex,
    );
  }
}