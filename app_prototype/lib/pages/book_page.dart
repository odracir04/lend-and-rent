import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../database/users.dart';
import 'chat_page.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key, required this.bookName, required this.authorName,
    required this.location, required this.imagePath, required this.renter,
    required this.genres, required this.darkTheme});

  final String bookName, authorName, location, imagePath, renter;
  final List<dynamic> genres;
  final bool darkTheme;

  @override
  State<StatefulWidget> createState() => BookPageState();
}

class BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      IconButton(
                          onPressed: () {Navigator.pop(context);},
                          icon: const Icon(Icons.arrow_back, size: 30,)
                      )
                    ]
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                      bottom: MediaQuery.of(context).viewInsets.bottom
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 50,),
                      Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Image.network(widget.imagePath)
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                          ]
                      ),
                      const SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Title: ${widget.bookName}',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ]
                      ),
                      const SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Genres: ',
                              style: TextStyle(fontSize: 20),
                            ),
                            for (int i = 0; i < 2 && i < widget.genres.length; i++)
                              if (i != widget.genres.length - 1) Text(
                                '${widget.genres[i]}, ',
                                style: const TextStyle(fontSize: 20),
                              )
                              else Text(
                                '${widget.genres[i]}',
                                style: const TextStyle(fontSize: 20),
                              ),
                          ]
                      ),
                      for (int i = 2; i < widget.genres.length; i += 3) Row(
                        children: [
                          for (int j = i; j < i + 3 && j < widget.genres.length; j++) Column(
                          children: [
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  if (j != widget.genres.length - 1) Text(
                                    '${widget.genres[j]}, ',
                                    style: const TextStyle(fontSize: 20),
                                  )
                                  else Text(
                                    '${widget.genres[j]}',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              )
                            ]
                          )
                        ]
                      ),
                      const SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Author: ${widget.authorName}',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ]
                      ),
                      const SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Location: ${widget.location}',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ]
                      ),
                      const SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Renter: ',
                              style: TextStyle(fontSize: 20),
                            ),
                            FutureBuilder(
                                future: Future.wait([getReceiverName(widget.renter)]),
                                builder: (builder, snapshot) {
                                  if (snapshot.connectionState != ConnectionState.waiting) {
                                    List<String?> data = snapshot.data ?? [];
                                    return Text(
                                      data[0]!,
                                      style: const TextStyle(fontSize: 20),
                                    );
                                  }
                                  else {
                                    return const Text('');
                                  }
                                }
                            )
                          ]
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                          width: 0.90 * MediaQuery.of(context).size.width,
                          height: 50,
                          child: TextButton(
                            onPressed: () {Navigator.push(context,
                                MaterialPageRoute(builder: (context)
                                => ChatPage(
                                  receiverEmail: widget.renter,
                                  userEmail: FirebaseAuth.instance.currentUser!.email ?? "",
                                  db: FirebaseFirestore.instance,
                                )));},
                            child: Text('Chat', style: TextStyle(color: widget.darkTheme ? Colors.black : Colors.white70)),
                          )
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}