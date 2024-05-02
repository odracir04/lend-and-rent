import 'package:cloud_firestore/cloud_firestore.dart';

Future<String?> getName(String? email) async {
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
      String? name = userDocument['first_name'] + " " + userDocument['last_name'];
      return name;
    } else {
      return ' ';
    }
  } catch (e) {
    print('Error getting user name: $e');
    ' ';
  }
}

Future<String?> getLocation(String? email) async{
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