import 'package:flutter/material.dart';

import '../pages/user_page.dart';

class UserIcon extends StatefulWidget {
  const UserIcon({super.key});

  @override
  State<StatefulWidget> createState() => UserIconState();
}

class UserIconState extends State<UserIcon> {
  void _onPressed() {
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) { return const UserPage(); }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _onPressed,
      icon: const Icon(Icons.person)
    );
  }

}