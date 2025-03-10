import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    required this.db,
    required this.auth,
    required this.storage
  });

  final String bookName, authorName, location, imagePath, renter,userPicture;
  final VoidCallback changeTheme;
  final bool darkTheme;
  final FirebaseFirestore db;
  final FirebaseStorage storage;
  final FirebaseAuth auth;
  Map<String, dynamic> book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const Key("book_card_detector"),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BookPage(
                book: book, darkTheme: darkTheme, db: db, auth: auth,
                changeTheme: changeTheme, storage: storage,
              )
          ),
        );
      },
      child: SizedBox(
        height: 150,
        child: Card(
          margin: const EdgeInsets.only(bottom: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).cardColor,
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                    child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 100,
                      child: imagePath == "assets/images/book.jpg"
                          ? Image.asset(imagePath, fit: BoxFit.cover)
                          : Image.network(imagePath, fit: BoxFit.cover),
                    )
                  ),
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
                                style: TextStyle(
                                  color: darkTheme ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                bookName,
                                style: TextStyle(
                                  color: darkTheme ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                authorName,
                                style: TextStyle(
                                  color: darkTheme ? Colors.white : Colors.black,
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
        ),
      ),
    );
  }
}
