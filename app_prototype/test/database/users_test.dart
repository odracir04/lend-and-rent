
import 'package:app_prototype/database/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final FakeFirebaseFirestore fakeFirestore = FakeFirebaseFirestore();

  setUpAll(() async {

    await fakeFirestore.collection('users').add(
        {
          "display_email": true,
          "email": "test@gmail.com",
          "location": "Porto",
          "first_name": "Rui",
          "last_name": "Pereira",
          "profile_url": ""
        }
    );
    await fakeFirestore.collection('users').add(
        {
          "display_email": false,
          "email": "test1@gmail.com",
          "location": "Trofa",
          "first_name": "Paulo",
          "last_name": "Carvalhal",
          "profile_url":"assets/images/profile.png"
        }
    );
    await fakeFirestore.collection('reviews').add(
      {
        "review_receiver": "test@gmail.com",
        "review_sender" : "test1@gmail.com",
        "review_stars" : 5,
        "review_message": "Testing review"
      }
    );

  });
  // Getters
  // Get user first name - success
  testWidgets('Get user first name - success', (WidgetTester tester) async {
    final String? firstName = await getFirstName(fakeFirestore,'test@gmail.com');
    expect(firstName, equals('Rui'));
  });

  // Get user first name - fail
  testWidgets('Get user first name - fail ', (WidgetTester tester) async {
    final String? firstName = await getFirstName(fakeFirestore,'test@gmail.com');
    expect(firstName, isNot(equals('Tiago')));
  });

  // Get user last name - success
  testWidgets('Get user last name - success', (WidgetTester tester) async {
    final String? firstName = await getLastName(fakeFirestore,'test@gmail.com');
    expect(firstName, equals('Pereira'));
  });

  // Get user last name - fail
  testWidgets('Get user last name - success', (WidgetTester tester) async {
    final String? firstName = await getLastName(fakeFirestore,'test@gmail.com');
    expect(firstName, isNot(equals('Silva')));
  });

  // Get user location - success
  testWidgets('Get user location - success', (WidgetTester tester) async {
    final String? location = await getLocation(fakeFirestore,'test1@gmail.com');
    expect(location,equals('Trofa'));
  });

  // Get user location - fail
  testWidgets('Get user location - fail', (WidgetTester tester) async {
    final String? location = await getLocation(fakeFirestore,'test1@gmail.com');
    expect(location,isNot(equals('Vila Nova de Famalicão')));
  });

  // Get user display Email - success
  testWidgets('Get user display email - success', (WidgetTester tester) async {
    final bool? email = await getDisplayEmail(fakeFirestore,'test@gmail.com');
    expect(email, equals(true));
  });

  // Get user display Email - fail
  testWidgets('Get user display email - fail', (WidgetTester tester) async {
    final bool? email = await getDisplayEmail(fakeFirestore,'test@gmail.com');
    expect(email, isNot(equals(false)));
  });

  // Get user profile_picture, success
  testWidgets('Get user profile picture - success', (WidgetTester tester) async {
    final String? profile_picture = await getPictureUrl(fakeFirestore,'test1@gmail.com');
    expect(profile_picture, equals("assets/images/profile.png"));

  });

  // Get user profile_picture, fail
  testWidgets('Get user profile picture - fail ', (widgetTester) async{
    final String? profile_picture = await getPictureUrl(fakeFirestore, 'test@gmail.com');
    expect(profile_picture, isNot(equals("assets/images/profile.png")));
  });

  // Email is registered - success
  testWidgets('Test if email is on db - success', (WidgetTester tester) async {
    final bool emailOnDb = await checkIfEmailExists(fakeFirestore, 'test1@gmail.com');
    expect(emailOnDb, true);
  });

  // Email is registered - fail
  testWidgets('Test if email is on db - fail', (WidgetTester tester) async {
    final bool emailOnDb = await checkIfEmailExists(fakeFirestore, 'test2@gmail.com');
    expect(emailOnDb, false);
  });

  // Updates

  // Update user first name - success
  testWidgets('Update user first name - success', (WidgetTester tester) async {
    final result = await updateUserFirstName(fakeFirestore,'test@gmail.com', 'Alexandre');
    expect(result, true);

    final userSnapshot = await fakeFirestore
        .collection('users')
        .where('email', isEqualTo: 'test@gmail.com')
        .get();
    final userDoc = userSnapshot.docs.first;
    expect(userDoc['first_name'], 'Alexandre');
  });

  // Update user first name - fail
  testWidgets('Update user first name - fail', (WidgetTester tester) async {
    // First, update the user's first name
    final result = await updateUserFirstName(fakeFirestore, 'test@gmail.com', 'Matos');
    expect(result, true);

    // Ensure that the update was successful
    final userSnapshot = await fakeFirestore
        .collection('users')
        .where('email', isEqualTo: 'test@gmail.com')
        .get();
    final userDoc = userSnapshot.docs.first;
    expect(userDoc['first_name'], equals('Matos'));

    final result2 = await updateUserFirstName(fakeFirestore, 'test4@gmail.com', 'Alexandre');
    expect(result2, false);
  });

  // Update user last name - success
  testWidgets('Update user last name - success', (WidgetTester tester) async {
    final result = await updateUserLastName(fakeFirestore,'test@gmail.com', 'Alexandre');
    expect(result, true);

    final userSnapshot = await fakeFirestore
        .collection('users')
        .where('email', isEqualTo: 'test@gmail.com')
        .get();
    final userDoc = userSnapshot.docs.first;
    expect(userDoc['last_name'], 'Alexandre');
  });

  // Update user last name - fail
  testWidgets('Update user last name - fail', (WidgetTester tester) async {
    // First, update the user's last name
    final result = await updateUserLastName(fakeFirestore, 'test@gmail.com', 'Matos');
    expect(result, true);

    // Ensure that the update was successful
    final userSnapshot = await fakeFirestore
        .collection('users')
        .where('email', isEqualTo: 'test@gmail.com')
        .get();
    final userDoc = userSnapshot.docs.first;
    expect(userDoc['last_name'], equals('Matos'));

    final result2 = await updateUserLastName(fakeFirestore, 'test4@gmail.com', 'Alexandre');
    expect(result2, false);
  });

  // Update Location - success
  testWidgets('Update user location - success', (WidgetTester tester) async {
    final result = await updateUserLocation(fakeFirestore,'test1@gmail.com', 'Roma');
    expect(result, true);

    final userSnapshot = await fakeFirestore
        .collection('users')
        .where('email', isEqualTo: 'test1@gmail.com')
        .get();
    final userDoc = userSnapshot.docs.first;
    expect(userDoc['location'], 'Roma');
  });

  // Update Location - fail
  testWidgets('Update user location - fail', (WidgetTester tester) async {
    final result = await updateUserLocation(fakeFirestore, 'test@gmail.com', 'Gaia');
    expect(result, true);

    final userSnapshot = await fakeFirestore
        .collection('users')
        .where('email', isEqualTo: 'test@gmail.com')
        .get();
    final userDoc = userSnapshot.docs.first;
    expect(userDoc['location'], equals('Gaia'));

    final result2 = await updateUserLocation(fakeFirestore, 'test4@gmail.com', 'Gaia');
    expect(result2, false);
  });

  // Update display_email - success
  testWidgets('Update display email - success', (WidgetTester tester) async {
    final result = await updateDisplayEmail(fakeFirestore,'test1@gmail.com', false);
    expect(result, true);

    final userSnapshot = await fakeFirestore
        .collection('users')
        .where('email', isEqualTo: 'test1@gmail.com')
        .get();
    final userDoc = userSnapshot.docs.first;
    expect(userDoc['display_email'], false);
  });

  // Update display_email - fail
  testWidgets('Update display email - fail', (WidgetTester tester) async {
    final result = await updateDisplayEmail(fakeFirestore,'test1@gmail.com', false);
    expect(result, true);

    final userSnapshot = await fakeFirestore
        .collection('users')
        .where('email', isEqualTo: 'test1@gmail.com')
        .get();
    final userDoc = userSnapshot.docs.first;
    expect(userDoc['display_email'], false);

    final result2 = await updateDisplayEmail(fakeFirestore,'test4@gmail.com', false);
    expect(result2, false);
  });

  // Get reviews
  testWidgets('Get reviews for test@gmail.com', (WidgetTester tester) async {
    List<DocumentSnapshot> reviews = await getReviews(fakeFirestore, "test@gmail.com");
    expect(reviews.length, 1);
    for (int i = 0; i < reviews.length; i++){
      expect(reviews[i]['review_receiver'], equals("test@gmail.com"));
      expect(reviews[i]['review_sender'], equals("test1@gmail.com"));
      expect(reviews[i]['review_stars'], equals(5));
      expect(reviews[i]['review_message'], equals("Testing review"));
    }
  });

  // Create reviews
  testWidgets('Create reviews for test@gmail.com', (WidgetTester tester) async {
    final result = await createReview(
        fakeFirestore, 2, "Hello", "test4@gmail.com", "test@gmail.com");
    expect(result, true);

    List<DocumentSnapshot> reviews = await getReviews(
        fakeFirestore, "test@gmail.com");
    expect(reviews.length, 2);
  });


  // Update user profile_image
  testWidgets('Update user profile image', (WidgetTester tester) async {
    final result = await updateProfilePicture(fakeFirestore,'test1@gmail.com','person.jpg');
    expect(result, true);

    final userSnapshot = await fakeFirestore
        .collection('users')
        .where('email', isEqualTo: 'test1@gmail.com')
        .get();
    final userDoc = userSnapshot.docs.first;
    expect(userDoc['profile_url'], 'person.jpg');
  });

  // Assemble name
  test('Create full name', () {
    final result = assembleName('John', 'Doe');
    expect(result, equals('John Doe'));
  });










}