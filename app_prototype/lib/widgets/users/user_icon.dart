import 'package:app_prototype/pages/profile_page.dart';
import 'package:flutter/material.dart';


class UserIcon extends StatefulWidget {
  const UserIcon({super.key, required this.userPicture});
  final String userPicture;

  @override
  State<StatefulWidget> createState() => UserIconState();
}

class UserIconState extends State<UserIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: null,
      icon: ClipOval(
        child: SizedBox(
          width: 40,
          height: 40,
          child: widget.userPicture == "assets/images/profile.png"
              ? Image.asset("assets/images/profile.png", fit: BoxFit.cover)
              : Image.network(widget.userPicture, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
