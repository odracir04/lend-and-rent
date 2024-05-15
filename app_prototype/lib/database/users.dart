import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Future<String?> getReceiverName(String? email) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  email = email?.toLowerCase();
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    // Check if only 1 email matches for the user.
    if (querySnapshot.docs.isNotEmpty) {
      var userDocument = querySnapshot.docs.first;
      String? name = assembleName(userDocument['first_name'], userDocument['last_name']);
      return name;
    } else {
      return ' ';
    }
  } catch (e) {
    print('Error getting user name: $e');
    ' ';
  }
}

/// Get reviews for a user email.
Future<List<DocumentSnapshot>> getReviews(FirebaseFirestore? db, String? email) async {
  QuerySnapshot reviewsSnapshot = await db!.collection('reviews').where('review_receiver', isEqualTo: email).get();
  List<DocumentSnapshot> myReviews = [];
  for (DocumentSnapshot review in reviewsSnapshot.docs) {
    myReviews.add(review);
  }
  return myReviews;
}

/// Get reviews a user has in a profile.
Future<List<DocumentSnapshot>?> getReviewsForProfile(FirebaseFirestore? db, String? profileEmail, String? receiverEmail) async {
  QuerySnapshot reviewsSnapshot = await db!.collection('reviews')
      .where('review_sender', isEqualTo: profileEmail)
      .where('review_receiver', isEqualTo: receiverEmail)
      .get();
  List<DocumentSnapshot> myReviews = [];
  for (DocumentSnapshot review in reviewsSnapshot.docs) {
    myReviews.add(review);
  }
  // An user can only have one review for each profile.
  if (myReviews.length > 1){
    return null;
  }
  return myReviews;
}

/// Create a review on name of review_sender to review_receiver.
/// If create review returns true, the function was successfully else an error happened.
Future<bool> createReview(FirebaseFirestore? db, double? stars, String? reviewMessage, String? senderEmail, String? receiverEmail) async{
  reviewMessage = reviewMessage?.trim();
  try {
    await db?.collection('reviews').add({
      'review_receiver': receiverEmail,
      'review_sender': senderEmail,
      'review_message': reviewMessage,
      'review_stars': stars,
    });
    print('Review sent successfully');
    return true;
  } catch (e) {
    print('Error sending review: $e');
    return false;
  }
}


Future<String?> getReceiverLocation(String? email) async{
  FirebaseFirestore db = FirebaseFirestore.instance;
  email = email?.toLowerCase();
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    // Check if only 1 email matches for the user.
    if (querySnapshot.docs.isNotEmpty && querySnapshot.docs.length == 1) {
      var userDocument = querySnapshot.docs.first;
      String? location = userDocument['location'];
      return location;
    } else {
      return ' ';
    }
  } catch (e) {
    print('Error getting user location: $e');
    return ' ';
  }
}

/// Get one of the fields of user.
/// First/last name, location, display_email, picture and email.
Future<dynamic> getField(FirebaseFirestore db,String? email, String? fieldName) async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty && querySnapshot.docs.length == 1) {
      var userDocument = querySnapshot.docs.first;
      var fieldValue = userDocument[fieldName!];
      return fieldValue;
    }
    else {
      return '';
    }
  }
  catch (e) {
    print('Error getting user $fieldName: $e');
    return '';
  }
}

/// Get user first name.
Future<String?> getFirstName(FirebaseFirestore db, String? email) async {
  if (email == null){
    return null;
  }
  return await getField(db,email, 'first_name');
}
/// Get user last name.
Future<String?> getLastName(FirebaseFirestore db,String? email) async {
  if (email == null){
    return null;
  }
  return await getField(db,email, 'last_name');
}
/// Get user location.
Future<String?> getLocation(FirebaseFirestore db,String? email) async {
  if (email == null){
    return null;
  }
  return await getField(db,email, 'location');
}
/// Display email in profile.
Future<bool?> getDisplayEmail(FirebaseFirestore db,String? email) async {
  if (email == null){
    return null;
  }
  return await getField(db,email, 'display_email');
}
/// Get profile picture
Future<String?> getPictureUrl(FirebaseFirestore db,String? email) async {
  if (email == null){
    return null;
  }
  return await getField(db,email, 'profile_url');
}

/// Update user password.
Future<bool> updatePassword(String? email, String? newPassword) async {
  newPassword = newPassword?.trim();
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword!);
      print('User password updated with success');
      return true;
    }
    else {
      print('No user is currently signed in.');
      return false;
    }
  }
  catch (e) {
    print('Failed to update password: $e');
    return false;
  }
}

/// Check if an email exists in the database
/// Main use -> recover password and sign-in/sign-up.
Future<bool> checkIfEmailExists(FirebaseFirestore db, String? email) async{
  if (email == null){
    print("Some of the parameters are null");
    return false;
  }
  email = email.trim();
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    print('Error checking email existence: $e');
    return false;
  }
}

/// Create a new record for a user in the database.
Future<bool> createUserRecord(FirebaseFirestore db, FirebaseStorage storage, String? email, String? firstName, String? lastName) async {
  email = email?.trim();
  firstName = firstName?.trim();
  lastName = lastName?.trim();

  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      print("Email already exists");
      return false;
    }

    // Add user record to Firestore
    await db.collection('users').add({
      'email': email!.toLowerCase(),
      'first_name': firstName!,
      'last_name': lastName!,
      'location': "Porto",
      'display_email': false,
      'profile_url': "assets/images/profile.png", // Include profile URL in Firestore
    });

    print('User record created successfully');
    return true;
  } catch (e) {
    print('Error creating user record: $e');
    return false;
  }
}

/// Retrieve profile images.
/// There is only one image for each profile.
// Retrieve profile image file from Firebase Storage or default asset.
Future<dynamic> retrieveProfileImageFile(FirebaseStorage storage, FirebaseFirestore db, String email) async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String profileUrl = querySnapshot.docs.first['profile_url'];

      // If image is the default asset
      if (profileUrl == "assets/images/profile.png") {
        return const AssetImage("assets/images/profile.png");
      }

      Reference profileImgRef = storage.ref("profiles/$email/$profileUrl");
      String downloadUrl = await profileImgRef.getDownloadURL();
      return FileImage(File(downloadUrl));

    } else {
      print('No user found for email: $email');
      return null;
    }
  } catch (e) {
    print('Error retrieving profile image file: $e');
    return null;
  }
}

Future<bool> updateProfilePicture(FirebaseFirestore db,String? email, String? profileUrl) async {
  if (email == null || profileUrl == null){
    print("Some of the parameters are null");
    return false;
  }
  try {
    final userQuerySnapshot = await db
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (userQuerySnapshot.docs.isNotEmpty) {
      final userId = userQuerySnapshot.docs.first.id;

      await db
          .collection('users')
          .doc(userId)
          .update({'profile_url': profileUrl});

      print('Profile picture updated successfully');
      return true;
    }
    else {
      print('User with email $email not found');
      return false;
    }
  }
  catch (e) {
    print('Error updating profile picture: $e');
    return false;
  }
}



/// Update the first name of a user.
Future<bool> updateUserFirstName(FirebaseFirestore db, String? email, String? newFirstName) async {
  if (email == null || newFirstName == null){
    print("Some of the parameters are null");
    return false;
  }
  try {
    final userQuerySnapshot = await db
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (userQuerySnapshot.docs.isNotEmpty) {
      final userId = userQuerySnapshot.docs.first.id;
      newFirstName = newFirstName?.trim();
      await db
          .collection('users')
          .doc(userId)
          .update({'first_name': newFirstName});

      print('User first name updated successfully');
      return true;
    }
    else {
      print('User with email $email not found');
      return false;
    }
  }
  catch (e) {
    print('Error updating user first name: $e');
    return false;
  }
}

/// Update the last name of a user.
Future<bool> updateUserLastName(FirebaseFirestore db,String? email, String? newLastName) async {
  if (email == null || newLastName == null){
    print("Some of the parameters are null");
    return false;
  }
  try {
    final userQuerySnapshot = await db
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (userQuerySnapshot.docs.isNotEmpty) {
      newLastName = newLastName?.trim();
      final userId = userQuerySnapshot.docs.first.id;
      await db
          .collection('users')
          .doc(userId)
          .update({'last_name': newLastName});

      print('User last name updated successfully');
      return true;
    }
    else {
      print('User with email $email not found');
      return false;
    }
  }
  catch (e) {
    print('Error updating user last name: $e');
    return false;
  }
}

/// Update the user location.
Future<bool> updateUserLocation(FirebaseFirestore db,String? email, String? newLocation) async {
  if (email == null || newLocation == null){
    print("Some of the parameters are null");
    return false;
  }

  try {
    final userQuerySnapshot = await db
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (userQuerySnapshot.docs.isNotEmpty) {
      final userId = userQuerySnapshot.docs.first.id;
      newLocation = newLocation?.trim();
      await db
          .collection('users')
          .doc(userId)
          .update({'location': newLocation});

      print('User location updated successfully');
      return true;
    }
    else {
      print('User with email $email not found');
      return false;
    }
  }
  catch (e) {
    print('Error updating user location: $e');
    return false;
  }
}
/// Update the display Email in profile
/// If true -> profile shows email and location
/// else profile only shows location
Future<bool> updateDisplayEmail(FirebaseFirestore db,String? email, bool? displayEmail) async {
  if (email == null || displayEmail == null){
    print("Some of the parameters are null");
    return false;
  }
  try {
    final userQuerySnapshot = await db
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (userQuerySnapshot.docs.isNotEmpty) {
      final userId = userQuerySnapshot.docs.first.id;

      await db
          .collection('users')
          .doc(userId)
          .update({'display_email': displayEmail});

      print('Display email updated successfully');
      return true;
    }
    else {
      print('User with email $email not found');
      return false;
    }
  }
  catch (e) {
    print('Error updating display email: $e');
    return false;
  }
}


/// Get full name of user.
/// Joins both user first name and last name.
String? assembleName(String? userFirstName, String? userLastName) {
  if (userFirstName == null || userLastName == null){
    return null;
  }
  String name = '$userFirstName $userLastName';
  return name;
}

