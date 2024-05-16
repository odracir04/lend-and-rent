import 'package:app_prototype/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../pages/book_page.dart';
import '/widgets/users/user_icon.dart';

class BookCard extends StatelessWidget {
  BookCard({
    super.key,
    required this.book,
    required this.changeTheme,
    required this.darkTheme,
    required this.bookName,
    required this.authorName,
    required this.location,
    required this.imagePath,
    required this.userPicture,
    required this.renter,
  });

  final String bookName, authorName, location, imagePath, renter,userPicture;
  final VoidCallback changeTheme;
  final bool darkTheme;
  Map<String, dynamic> book;

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookPage(
                    book: book, darkTheme: darkTheme, db: FirebaseFirestore.instance,
                    changeTheme: changeTheme,
                  )
                ),
              );
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
                      child: UserIcon(userPicture: userPicture),
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
