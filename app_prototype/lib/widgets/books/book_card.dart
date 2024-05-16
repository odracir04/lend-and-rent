import 'package:app_prototype/pages/book_page.dart';

import '/widgets/users/user_icon.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  BookCard({super.key, required this.book, required this.darkTheme});

  Map<String, dynamic> book;
  final bool darkTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {Navigator.push(context,
          MaterialPageRoute(builder: (context)
          => BookPage(book: book, darkTheme: darkTheme,)));},
      child: Card(
          margin: const EdgeInsets.only(bottom: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).cardColor,
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: book['imagePath'] == "assets/images/book.jpg" ? Image.asset(
                      book['imagePath'], fit: BoxFit.cover
                  )
                      : Image.network(
                      book['imagePath'], fit: BoxFit.cover
                  )),
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
                            constraints: const BoxConstraints(maxHeight: 75, maxWidth: 100),
                            child: const UserIcon(),
                          ),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(book['location'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),),
                                  Text(book['title'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                    ),),
                                  Text(book['author'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                    ),),
                                ],
                              )),
                        ],
                      )
                    ],
                  )
              ),
            ],
          )
      ),
    );
  }
}