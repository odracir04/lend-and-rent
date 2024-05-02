import 'package:app_prototype/database/users.dart';
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
          "last_name": "Bode",
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
          "profile_url":"assets/images/profile.jpg"
        }
    );

  });
  // Getters

  // Get user first name
  testWidgets('Get user first name', (WidgetTester tester) async {
    final String? firstName = await getFirstName(fakeFirestore,'test@gmail.com');
    expect(firstName, equals('Rui'));

  });

  // Get user last name
  testWidgets('Get user last name', (WidgetTester tester) async {
    final String? firstName = await getLastName(fakeFirestore,'test@gmail.com');
    expect(firstName, equals('Bode'));
  });

  // Get user location
  testWidgets('Get user location', (WidgetTester tester) async {
    final String? location = await getLocation(fakeFirestore,'test1@gmail.com');
    expect(location,equals('Trofa'));

  });

  // Get user email
  testWidgets('Get user display email', (WidgetTester tester) async {
    final bool? email = await getDisplayEmail(fakeFirestore,'test@gmail.com');
    expect(email, equals(true));

  });

  // Get user profile_picture
  testWidgets('Get user display email', (WidgetTester tester) async {
    final String? profile_picture = await getProfilePicture(fakeFirestore,'test1@gmail.com');
    expect(profile_picture, equals("assets/images/profile.jpg"));

  });

  // Email is registered (Failure)
  testWidgets('Test if email is on db (Failure)', (WidgetTester tester) async {
    final bool? emailOnDb = await checkIfEmailExists(fakeFirestore, 'test2@gmail.com');
    expect(emailOnDb, false);
  });

  // Email is registered (Success)
  testWidgets('Test if email is on db (Success)', (WidgetTester tester) async {
    final bool? emailOnDb = await checkIfEmailExists(fakeFirestore, 'test1@gmail.com');
    expect(emailOnDb, true);
  });

  // Update user first name
  testWidgets('Update user first name ', (WidgetTester tester) async {
    final result = await updateUserFirstName(fakeFirestore,'test@gmail.com', 'Alexandre');
    expect(result, true);

    final userSnapshot = await fakeFirestore
        .collection('users')
        .where('email', isEqualTo: 'test@gmail.com')
        .get();
    final userDoc = userSnapshot.docs.first;
    expect(userDoc['first_name'], 'Alexandre');
  });

  // Update user last name
  testWidgets('Update user last name', (WidgetTester tester) async {
    final result = await updateUserLastName(fakeFirestore,'test@gmail.com', 'Alexandre');
    expect(result, true);

    final userSnapshot = await fakeFirestore
        .collection('users')
        .where('email', isEqualTo: 'test@gmail.com')
        .get();
    final userDoc = userSnapshot.docs.first;
    expect(userDoc['last_name'], 'Alexandre');
  });

  // Update Location
  testWidgets('Update user location', (WidgetTester tester) async {
    final result = await updateUserLocation(fakeFirestore,'test1@gmail.com', 'Roma');
    expect(result, true);

    final userSnapshot = await fakeFirestore
        .collection('users')
        .where('email', isEqualTo: 'test1@gmail.com')
        .get();
    final userDoc = userSnapshot.docs.first;
    expect(userDoc['location'], 'Roma');
  });

  // Update display_email
  testWidgets('Update display email', (WidgetTester tester) async {
    final result = await updateDisplayEmail(fakeFirestore,'test1@gmail.com', false);
    expect(result, true);

    final userSnapshot = await fakeFirestore
        .collection('users')
        .where('email', isEqualTo: 'test1@gmail.com')
        .get();
    final userDoc = userSnapshot.docs.first;
    expect(userDoc['display_email'], false);
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