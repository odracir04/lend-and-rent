import 'package:app_prototype/database/books.dart';
import 'package:app_prototype/widgets/books/book_list.dart';
import 'package:app_prototype/widgets/filter_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';


import 'package:flutter/material.dart';
/*
Do navigation bar between menus.
Do profile page.
Do fake login/register in firebase if not real done.
In forms put error notifications if criteria not met.
In forms put success messages if criteria not met.
 */

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key, required this.changeTheme, required this.darkTheme}) : super(key: key);

  final VoidCallback changeTheme;

  // Email is passed by Main app.
  bool darkTheme;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_pic.jpg'), // You can use your actual profile picture here
            ),
            SizedBox(height: 20),
            Text(
              'John Doe', // Replace with actual user's name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Software Engineer', // Replace with actual user's bio
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            // Add more widgets to display other information like follower count, recent activity, etc.
          ],
        ),
      ),
    );
  }
}