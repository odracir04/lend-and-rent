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
        ListTile(
          title: Text("User ${users[index]}"),
          leading: const Icon(Icons.person),
        ));
  }
}