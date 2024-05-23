import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'book_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../database/users.dart';

class BookList extends StatefulWidget {

  BookList({Key? key, required this.changeTheme, required this.darkTheme
    , required this.books, required this.db, required this.auth,
      required this.storage});

  final Future<List<DocumentSnapshot>> books;
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  final FirebaseStorage storage;
  final VoidCallback changeTheme;
  final bool darkTheme;

  @override
  State<StatefulWidget> createState() => BookListState();
}

class BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.books,
      builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
        if (snapshot.hasError) {
          return Text("ERROR: ${snapshot.error}");
        } else {
          List<DocumentSnapshot> books = snapshot.data ?? [];
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: books.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> bookData = books[index].data() as Map<String, dynamic>;
                bookData['id'] = books[index].id;
                return FutureBuilder(
                  future: getPictureUrl(widget.db, bookData['renter']),
                  builder: (context, AsyncSnapshot<String?> userPictureSnapshot) {
                    if (userPictureSnapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: 150,
                        child: Center(child: CircularProgressIndicator(
                          color: widget.darkTheme ? Colors.white : Colors.black54,),),
                      );
                    } else if (userPictureSnapshot.hasError) {
                      return SizedBox(
                        height: 150,
                        child: Text("ERROR: ${userPictureSnapshot.error}"),
                      );
                    } else {
                      String? userPicture = userPictureSnapshot.data;
                      return BookCard(
                        book: bookData,
                        changeTheme: widget.changeTheme,
                        darkTheme: widget.darkTheme,
                        bookName: "${bookData['title']}",
                        authorName: "${bookData['author']}",
                        imagePath: "${bookData['imagePath']}",
                        location: "${bookData['location']}",
                        renter: "${bookData['renter']}",
                        userPicture: userPicture ?? "",
                        db: widget.db,
                        auth: widget.auth,
                        storage: widget.storage,
                      );
                    }
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
