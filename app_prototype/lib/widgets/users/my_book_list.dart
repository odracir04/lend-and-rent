import 'package:app_prototype/database/books.dart';
import 'package:app_prototype/database/users.dart';
import 'package:app_prototype/widgets/books/book_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MyBookList extends StatefulWidget {
  const MyBookList({
    super.key,
    required this.visitingEmail,
    required this.darkTheme,
    required this.userEmail,
    required this.changeTheme,
    required this.db,
    required this.auth,
    required this.storage
  });

  final String visitingEmail;
  final VoidCallback changeTheme;
  final String userEmail;
  final bool darkTheme;
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  @override
  State<MyBookList> createState() => _MyBookListState();
}

class _MyBookListState extends State<MyBookList> {
  bool? accessToFunctionalities;
  List<DocumentSnapshot>? myBooks;
  String? userPicture;

  Future<void> setData() async {
    if (widget.visitingEmail == widget.userEmail) {
      accessToFunctionalities = true;
    } else {
      accessToFunctionalities = false;
    }
    final List<DocumentSnapshot> futureBooks = await getBooksForUser(widget.db, widget.visitingEmail);
    myBooks = futureBooks;

    userPicture = await getPictureUrl(widget.db, widget.visitingEmail);


  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: setData(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (myBooks == null || myBooks!.isEmpty) {
            return Center(
              child: Text(
                "This user is not selling books yet.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: widget.darkTheme? Colors.white : Colors.black)
              ),
            );
          } else {
            print(myBooks);
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: myBooks!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Map<String, dynamic> bookData =
                      (myBooks![index].data() as Map<String, dynamic>);
                      bookData['id'] = myBooks![index].id;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Column (
                          children: [
                            BookCard(
                              book: bookData,
                              changeTheme: widget.changeTheme,
                              darkTheme: widget.darkTheme,
                              bookName: "${bookData['title']}",
                              authorName: "${bookData['author']}",
                              imagePath: "${bookData['imagePath']}",
                              location: "${bookData['location']}",
                              renter: "${bookData['renter']}",
                              userPicture: userPicture!,
                              db: widget.db,
                              auth: widget.auth,
                              storage: widget.storage,
                            ),
                            SizedBox(height: index == myBooks!.length - 1 ? 100 : 5)
                          ],
                        )
                      );
                    },
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }
}
