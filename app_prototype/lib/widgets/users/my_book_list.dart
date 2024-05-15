import 'package:app_prototype/database/books.dart';
import 'package:app_prototype/widgets/books/book_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyBookList extends StatefulWidget {
  const MyBookList({
    super.key,
    required this.visitingEmail,
    required this.darkTheme,
    required this.userEmail,
    required this.changeTheme,
  });

  final String visitingEmail;
  final VoidCallback changeTheme;
  final String userEmail;
  final bool darkTheme;

  @override
  State<MyBookList> createState() => _MyBookListState();
}

class _MyBookListState extends State<MyBookList> {
  bool? accessToFunctionalities;
  List<DocumentSnapshot>? myBooks;

  Future<void> setData() async {
    if (widget.visitingEmail == widget.userEmail) {
      accessToFunctionalities = true;
    } else {
      accessToFunctionalities = false;
    }
    final List<DocumentSnapshot> futureBooks =
    await getBooksForUser(FirebaseFirestore.instance, widget.visitingEmail);
    myBooks = futureBooks;
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
            return const Center(
              child: Text(
                "This user is not selling books yet.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            );
          } else {
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Column (
                          children: [
                            BookCard(
                              changeTheme: widget.changeTheme,
                              darkTheme: widget.darkTheme,
                              bookName: "${bookData['title']}",
                              authorName: "${bookData['author']}",
                              imagePath: "${bookData['imagePath']}",
                              location: "${bookData['location']}",
                              renter: "${bookData['renter']}",
                            ),
                            const SizedBox(height: 100.0)
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
