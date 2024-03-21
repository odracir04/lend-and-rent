import 'package:app_prototype/widgets/user_list_item.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  UserList({super.key});

  final List<int> users = List.generate(10, (index) => index);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: users.length,
        itemBuilder: (context, index) =>
        const UserListItem());
  }
}