import 'package:app_prototype/widgets/book_list.dart';
import 'package:app_prototype/widgets/chat_button.dart';
import 'package:app_prototype/widgets/user_profile.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';

class OtherUserPage extends StatelessWidget {
  const OtherUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        children: [
          Row(
          children: [
            UserProfile(),
            Padding(
                padding: EdgeInsets.fromLTRB(80, 0, 0, 0),
                child: Row(children: [
                  ChatButton(),
                  ElevatedButton(onPressed: null, child: Text("Report"),),
                ],))
            ],
          ),
          Text("Books for Rent",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          BookList(),
          Text("Comments",),
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1,),
    );
  }

}