import 'package:flutter/material.dart';


class UserIcon extends StatefulWidget {
  const UserIcon({super.key});

  @override
  State<StatefulWidget> createState() => UserIconState();
}

class UserIconState extends State<UserIcon> {

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: null,
      icon: Image.asset("assets/images/profile.png", height: 30, width: 30,)
    );
  }

}