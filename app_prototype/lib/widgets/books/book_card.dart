import 'package:app_prototype/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/widgets/users/user_icon.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    Key? key,
    required this.changeTheme,
    required this.darkTheme,
    required this.bookName,
    required this.authorName,
    required this.location,
    required this.imagePath,
    required this.renter,
  }) : super(key: key);

  final String bookName, authorName, location, imagePath, renter;
  final VoidCallback changeTheme;
  final bool darkTheme;

  @override
  Widget build(BuildContext context) {
    final currentUserEmail = FirebaseAuth.instance.currentUser!.email;

    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Theme.of(context).cardColor,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (currentUserEmail != renter) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      changeTheme: changeTheme,
                      darkTheme: darkTheme,
                      receiverEmail: renter,
                      userEmail: currentUserEmail ?? "",
                      db: FirebaseFirestore.instance,
                    ),
                  ),
                );
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imagePath == "assets/images/book.jpg"
                  ? Image.asset(imagePath, fit: BoxFit.cover)
                  : Image.network(imagePath, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      constraints: const BoxConstraints(
                        maxHeight: 75,
                        maxWidth: 100,
                      ),
                      child: const UserIcon(),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            location,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            bookName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            authorName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
