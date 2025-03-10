import 'package:app_prototype/pages/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    required this.auth,
    required this.db,
    required this.storage
  });

  final FirebaseFirestore db;
  final String userName, userLocation, visitingEmail,userPicture;
  final VoidCallback changeTheme;
  final bool darkTheme;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GestureDetector(
        key: const Key('chat_app_bar_icon'),
        onTap: () {
          final currentUser = auth.currentUser;
          if (currentUser != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  changeTheme: changeTheme,
                  darkTheme: darkTheme,
                  profileEmail: visitingEmail,
                  db: db,
                  auth: auth,
                  storage: storage,
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
