import 'package:app_prototype/database/books.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../database/users.dart';
import 'chat_page.dart';

class BookPage extends StatefulWidget {
  BookPage({super.key, required this.book, required this.darkTheme});

  Map<String, dynamic> book;
  final bool darkTheme;

  @override
  State<StatefulWidget> createState() => BookPageState();
}

class BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {Navigator.pop(context);},
              icon: const Icon(Icons.arrow_back, size: 30,)
          ),
          title: Text(widget.book['title']),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 80,
          child: (widget.book['renter'] == FirebaseAuth.instance.currentUser!.email) ? TextButton(
                  onPressed: () {
                    FirebaseStorage storage = FirebaseStorage.instance;
                    Reference ref = storage.refFromURL(widget.book['imagePath']);
                    ref.delete();
                    deleteBook(FirebaseFirestore.instance, widget.book);
                    Navigator.pop(context);
                  },
                  child: Text('Remove book', style: TextStyle(color: widget.darkTheme ? Colors.black : Colors.white)),
                )
                : TextButton(
                    onPressed: () {Navigator.push(context,
                        MaterialPageRoute(builder: (context)
                        => ChatPage(
                          receiverEmail: widget.book['renter'],
                          userEmail: FirebaseAuth.instance.currentUser!.email ?? "",
                          db: FirebaseFirestore.instance,
                        )));},
                    child: Text('Chat', style: TextStyle(color: widget.darkTheme ? Colors.black : Colors.white)),
                  )
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Column(
              children: [
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
                                    child: Image.network(widget.book['imagePath'])
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
                              'Title: ${widget.book['title']}',
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
                            for (int i = 0; i < 2 && i < widget.book['genres'].length; i++)
                              if (i != widget.book['genres'].length - 1) Text(
                                '${widget.book['genres'][i]}, ',
                                style: const TextStyle(fontSize: 20),
                              )
                              else Text(
                                '${widget.book['genres'][i]}',
                                style: const TextStyle(fontSize: 20),
                              ),
                          ]
                      ),
                      for (int i = 2; i < widget.book['genres'].length; i += 3) Row(
                        children: [
                          for (int j = i; j < i + 3 && j < widget.book['genres'].length; j++) Column(
                          children: [
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  if (j != widget.book['genres'].length - 1) Text(
                                    '${widget.book['genres'][j]}, ',
                                    style: const TextStyle(fontSize: 20),
                                  )
                                  else Text(
                                    '${widget.book['genres'][j]}',
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
                              'Author: ${widget.book['author']}',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ]
                      ),
                      const SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Location: ${widget.book['location']}',
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
                                future: Future.wait([getReceiverName(widget.book['renter'])]),
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