import 'package:app_prototype/database/books.dart';
import 'package:app_prototype/pages/book_reviews_page.dart';
import 'package:app_prototype/pages/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../database/users.dart';
import '../widgets/users/user_icon.dart';
import 'chat_page.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key, required this.book, required this.darkTheme,
                    required this.db, required this.changeTheme,
                    required this.auth, required this.storage});

  final VoidCallback changeTheme;
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  final FirebaseStorage storage;
  final Map<String, dynamic> book;
  final bool darkTheme;

  @override
  State<StatefulWidget> createState() => BookPageState();
}

class BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {Navigator.pop(context);},
              icon: const Icon(Icons.arrow_back, size: 30,)
          ),
          title: Text(widget.book['title']),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: (widget.book['renter'] == widget.auth.currentUser!.email) ? TextButton(
                    onPressed: () {
                      Reference ref = widget.storage.refFromURL(widget.book['imagePath']);
                      ref.delete();
                      deleteBook(widget.db, widget.book);
                      Navigator.pop(context);
                    },
                    child: Text('Remove book', style: TextStyle(color: widget.darkTheme ? Colors.black : Colors.white)),
                  )
                      : TextButton(
                    onPressed: () {Navigator.push(context,
                        MaterialPageRoute(builder: (context)
                        => ChatPage(
                          darkTheme: widget.darkTheme,
                          changeTheme: widget.changeTheme,
                          receiverEmail: widget.book['renter'],
                          userEmail: widget.auth.currentUser!.email ?? "",
                          db: widget.db,
                          auth: widget.auth,
                          storage: widget.storage,
                        )));},
                    child: Text('Chat', style: TextStyle(color: widget.darkTheme ? Colors.black : Colors.white)),
                  )
              ),
              const SizedBox(width: 20,),
              Expanded(
                  child: TextButton(
                    onPressed: () {Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BookReviewsPage(
                          db: widget.db, book: widget.book['title'],
                          changeTheme: widget.changeTheme, darkTheme: widget.darkTheme,
                          auth: widget.auth,
                        ))
                    ); },
                    child: Text('Reviews', style: TextStyle(color: widget.darkTheme ? Colors.black : Colors.white)),
                  )
              )
            ],
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
                            const Text(
                              'Title: ',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                                widget.book['title'],
                                style: const TextStyle(fontSize: 20)
                            )
                          ]
                      ),
                      const SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Genres: ',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                            const Text(
                              'Author: ',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.book['author'],
                              style: const TextStyle(fontSize: 20),
                            )
                          ]
                      ),
                      const SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Location: ',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.book['location'],
                              style: const TextStyle(fontSize: 20),
                            ),
                          ]
                      ),
                      const SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder(
                                future: Future.wait([getReceiverName(widget.db, widget.book['renter']),
                                  getPictureUrl(widget.db, widget.book['renter'])]),
                                builder: (builder, snapshot) {
                                  if (snapshot.connectionState != ConnectionState.waiting) {
                                    List<String?> data = snapshot.data ?? [];
                                    return GestureDetector(
                                      onTap: () {
                                        final currentUser = widget.auth.currentUser;
                                        if (currentUser != null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProfilePage(
                                                db: widget.db,
                                                changeTheme: widget.changeTheme,
                                                darkTheme: widget.darkTheme,
                                                profileEmail: widget.book['renter'],
                                                auth: widget.auth,
                                                storage: widget.storage,
                                              ),
                                            ),
                                          );
                                        } else {
                                          print('FirebaseAuth.instance.currentUser is null');
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Renter: ',
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: UserIcon( userPicture: data[1]!,),
                                          ),
                                          Text(
                                              data[0]!,
                                              style: const TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
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
                ),
              ],
            )
        )
    );
  }
}