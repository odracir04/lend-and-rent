import 'package:app_prototype/widgets/user_icon.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Row(
          children: [
            UserIcon(),
            Column(
              children: [
                Text("Username"),
                Text("User location")
              ],
            ),
          ],
    ));
  }

}