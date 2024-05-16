import 'package:app_prototype/database/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../database/books.dart';

/// In the review class, you can write your own opinion about the user and give a 0 to 5 stars evaluation
class Review extends StatefulWidget {
  final VoidCallback changeTheme;
  final bool darkTheme;
  final String emailReview;
  final String receiver;
  final bool userReview;

  const Review({
    super.key,
    required this.userReview,
    required this.changeTheme,
    required this.darkTheme,
    required this.emailReview,
    required this.receiver,
  });

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  double rating = 0.0;
  String? reviewMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.darkTheme ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        child: Column(
          children: [
            Container(
              color: widget.darkTheme ? Colors.black : Colors.white,
              child: Column(
                children: [
                  PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 18,
                          color: widget.darkTheme ? Colors.white : Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Text(
                              "Choose rating",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: widget.darkTheme ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              initialRating: rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              glow: false,
                              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                              itemSize: 30.0, // Adjust the size of the stars
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (newRating) {
                                setState(() {
                                  rating = newRating;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Text(
                              "Write review",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: widget.darkTheme ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white), // Change border color to white
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white), // Change focused border color to white
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), // Increase height
                            hintText: 'Enter your review here...', // Add placeholder text
                          ),
                          onChanged: (value) {
                            setState(() {
                              reviewMessage = value;
                            });
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      const SizedBox(height: 20.0),
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
                                  sendReview(rating, reviewMessage);
                                },
                                child: const SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Write a review',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendReview(double rating, String? reviewMessage) async {
    try {
      bool success;
      widget.userReview ?
      success = await createReview(
        FirebaseFirestore.instance,
        rating,
        reviewMessage,
        widget.emailReview,
        widget.receiver,
      ) :
      success = await writeBookReview(
        FirebaseFirestore.instance,
        widget.receiver,
        widget.emailReview,
        rating,
        reviewMessage
      );
      ;
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Review written with success!',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Failed to write review!',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: $e',
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
