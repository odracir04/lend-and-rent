import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<String?> getReceiverName(String? email) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  email = email?.toLowerCase();
  print(email);
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
/// Get user profile picture.
Future<String?> getProfilePicture(FirebaseFirestore db, String? email) async{
  if (email == null){
    return null;
  }
  return await getField(db,email, 'profile_url');
}

/// Update user password.
Future<bool> updatePassword(String? email, String? newPassword) async {
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
Future<bool> createUserRecord({required String? email,required String? password, required String? firstName, required String? lastName, required String? location,}) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  email = email?.trim();
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty){
      print("Email already exists");
      return false;
    }
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    await db.collection('users').add({
      'email': email!.toLowerCase(),
      'first_name': firstName!,
      'last_name': lastName!,
      'location': location!,
      'display_email': true,
      'profile_url': 'assets/images/profile.jpg'
    });
    print('User record created successfully');
    return true;
  } catch (e) {
    print('Error creating user record: $e');
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
/// Function that updates the url in firestore for profile pictures.
/// Needs to be changed to local storage
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

/// This function gets the image profile default or user image.
/// If profilePictureUrl == null -> null.
/// == "assets/images/profile.jpg" -> default image.
/// other images.
dynamic getProfilePictureFile(String? profilePictureUrl) {
  if (profilePictureUrl == null){
    return null;
  }
  if (profilePictureUrl == "assets/images/profile.jpg") {
    return AssetImage(profilePictureUrl);
  }
  return FileImage(File(profilePictureUrl));
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