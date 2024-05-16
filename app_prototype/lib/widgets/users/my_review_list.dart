import 'package:app_prototype/database/users.dart';
import 'package:app_prototype/pages/review_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// Show all reviews for a user with userEmail
class MyReviewList extends StatefulWidget {
  final String visitingEmail;
  final String userEmail;
  final VoidCallback changeTheme;
  final bool darkTheme;

  const MyReviewList({
    super.key,
    required this.visitingEmail,
    required this.darkTheme,
    required this.userEmail,
    required this.changeTheme,
  });

  @override
  _MyReviewListState createState() => _MyReviewListState();
}

class _MyReviewListState extends State<MyReviewList> {
  late Future<List<DocumentSnapshot>> futureReviews;

  @override
  void initState() {
    super.initState();
    futureReviews = fetchReviews();
  }

  Future<List<DocumentSnapshot>> fetchReviews() async {
    final reviews = await getReviews(FirebaseFirestore.instance, widget.visitingEmail);
    return reviews;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: futureReviews,
      builder: (BuildContext context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final reviews = snapshot.data;

          if (reviews == null || reviews.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    "This user doesn't have reviews yet.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                if (widget.visitingEmail != widget.userEmail)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            autofocus: true,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color(0xFF474747)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Review(
                                    changeTheme: widget.changeTheme,
                                    darkTheme: widget.darkTheme,
                                    emailReview: widget.userEmail,
                                    emailReceiver: widget.visitingEmail,
                                  ),
                                ),
                              ).then((result) {
                                if (result == true) {
                                  setState(() {
                                    futureReviews = fetchReviews();
                                  });
                                }
                              });
                            },
                            child: const SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Write a review',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      final reviewData = review.data() as Map<String, dynamic>;
                      return Column(
                        children: [
                          ListTile(
                            tileColor: Colors.grey.shade800,
                            title: Text(reviewData['review_sender'] ?? 'No Title'),
                            subtitle: Text(reviewData['review_message'] ?? 'No Content'),
                            trailing: RatingBarIndicator(
                              rating: (reviewData['review_stars'] ?? 0).toDouble(),
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                          ),
                          Divider(color: Colors.grey.shade800, thickness: 1),
                        ],
                      );
                    },
                  ),
                ),
                if (widget.visitingEmail != widget.userEmail)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            autofocus: true,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color(0xFF474747)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Review(
                                    changeTheme: widget.changeTheme,
                                    darkTheme: widget.darkTheme,
                                    emailReview: widget.userEmail,
                                    emailReceiver: widget.visitingEmail,
                                  ),
                                ),
                              ).then((result) {
                                if (result == true) {
                                  setState(() {
                                    futureReviews = fetchReviews();
                                  });
                                }
                              });
                            },
                            child: const SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Write a review',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }
        }
      },
    );
  }
}
