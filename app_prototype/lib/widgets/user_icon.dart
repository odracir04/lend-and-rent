import 'package:flutter/material.dart';

import '../pages/other_user_page.dart';

class UserIcon extends StatefulWidget {
  const UserIcon({super.key});

  @override
  State<StatefulWidget> createState() => UserIconState();
}

class UserIconState extends State<UserIcon> {
  void _onPressed() {
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) { return const OtherUserPage(); }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _onPressed,
      icon: Image.asset("assets/images/profile.png", height: 30, width: 30,)
    );
  }

}