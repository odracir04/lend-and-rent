import 'package:app_prototype/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../users/user_icon.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({
    super.key,
    required this.visitingEmail,
    required this.changeTheme,
    required this.darkTheme,
    required this.userName,
    required this.userLocation,
    required this.userPicture,
  });

  final String userName, userLocation, visitingEmail,userPicture;
  final VoidCallback changeTheme;
  final bool darkTheme;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GestureDetector(
        onTap: () {
          final currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  changeTheme: changeTheme,
                  darkTheme: darkTheme,
                  profileEmail: visitingEmail,
                ),
              ),
            );
          } else {
            print('FirebaseAuth.instance.currentUser is null');
          }
        },
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName),
                Text(
                  userLocation,
                  style: const TextStyle(fontWeight: FontWeight.w300),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 70,
                  width: 70,
                  child: UserIcon( userPicture: userPicture,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
