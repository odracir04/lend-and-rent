import 'package:app_prototype/pages/other_user_page.dart';
import 'package:app_prototype/widgets/user_icon.dart';
import 'package:flutter/material.dart';

class UserListItem extends StatefulWidget {
  const UserListItem({super.key});

  @override
  State<StatefulWidget> createState() => UserListItemState();
}

class UserListItemState extends State<UserListItem> {

  void _onTap() {
    setState(() {
    Navigator.push(context, MaterialPageRoute
      (builder: (context) => const OtherUserPage()));
  });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const UserIcon(),
      title: const Text("User"),
      onTap: _onTap,
    );
  }

}