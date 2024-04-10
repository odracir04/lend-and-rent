import '/widgets/users/user_icon.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key,
                required this.bookName, required this.authorName,
                required this.location, required this.imagePath});

  final String bookName, authorName, location, imagePath;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Image.asset(
              imagePath, fit: BoxFit.cover
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
                      const UserIcon(),
                      Expanded(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(location),
                          Text(bookName, textAlign: TextAlign.left,),
                          Text(authorName),
                        ],
                      )),
                    ],
                  )
                ],
              )
            ),
          ],
      )
    ));
  }
}