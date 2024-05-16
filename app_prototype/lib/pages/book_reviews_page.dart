import 'package:app_prototype/database/books.dart';
import 'package:app_prototype/pages/review_page.dart';
import 'package:app_prototype/widgets/chat/message_write_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookReviewsPage extends StatefulWidget {
  const BookReviewsPage({super.key, required this.db, required this.book, required this.auth,
                          required this.changeTheme, required this.darkTheme});

  final FirebaseAuth auth;
  final bool darkTheme;
  final FirebaseFirestore db;
  final String book;
  final VoidCallback changeTheme;

  @override
  State<StatefulWidget> createState() => BookReviewsPageState();
}

class BookReviewsPageState extends State<BookReviewsPage> {

  late Future<List<DocumentSnapshot>> reviews;
  final TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    reviews = getBookReviews(widget.db, widget.book);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: reviews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else {
            List<DocumentSnapshot> reviewList = snapshot.data ?? [];
            return Scaffold(
              appBar: AppBar(title: const Text("Reviews")),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextButton(
                  onPressed: () { Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Review
                        (changeTheme: widget.changeTheme,
                        darkTheme: widget.darkTheme,
                        emailReview: widget.auth.currentUser!.email!,
                        receiver: widget.book,
                        userReview: false,))); },
                  child: Text("Write a review", style: TextStyle(color: widget.darkTheme ? Colors.black : Colors.white)),
                ),
              ),
              body: reviewList.isEmpty ? const Center(child: Text("No reviews"),)
              : ListView.builder(
                  itemCount: reviewList.length,
                  itemBuilder: (context, index) {
                    final review = reviewList[index].data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        ListTile(
                            title: Text(review['review_email'] ?? 'No Title'),
                            subtitle: Text(review['text'] ?? 'No Content'),
                            trailing: RatingBarIndicator(
                              rating: (review['review_stars'] ?? 0).toDouble(),
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            )),
                        Divider(color: Colors.grey.shade800, thickness: 1)
                      ],
                    );
                  }),
            );
          }
        });
  }

}