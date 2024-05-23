import 'package:app_prototype/pages/book_page.dart';
import 'package:app_prototype/widgets/books/book_card.dart';
import 'package:app_prototype/widgets/users/user_icon.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {

  FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
  MockFirebaseStorage mockFirebaseStorage = MockFirebaseStorage();
  MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();

  testWidgets("Basic BookCard structure", (WidgetTester tester) async {
    bool darkTheme = false;
    void testChangeTheme() { darkTheme = !darkTheme; }

    await mockNetworkImagesFor(()
    => tester.pumpWidget(
      MaterialApp(
        home: BookCard(
          bookName: 'name',
          authorName: 'author',
          userPicture: "assets/image/profile.png",
          darkTheme: darkTheme,
          changeTheme: testChangeTheme,
          imagePath: 'assets/images/book.jpg',
          location: 'Gaia',
          renter: "email@example.org",
          book: {},
          db: fakeFirebaseFirestore,
          auth: mockFirebaseAuth,
          storage: mockFirebaseStorage,
        ),
      ),
    ));

    // Expectations
    expect(find.byType(Stack), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(ClipRRect), findsOneWidget);
    expect(find.byType(Positioned), findsNWidgets(2));
    expect(find.byType(GestureDetector), findsNWidgets(2));
    expect(find.byType(Column), findsNWidgets(2));
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(UserIcon), findsOneWidget);

  });


  testWidgets("BookCard text", (WidgetTester tester) async {
    bool darkTheme = false;
    void testChangeTheme() { darkTheme = !darkTheme; }

    await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(home:
    BookCard(darkTheme: darkTheme, changeTheme: testChangeTheme,
      userPicture: "assets/images/profile.png",bookName: 'name', authorName: 'author',
      imagePath: 'assets/images/book.jpg', location: 'Gaia', renter: "email@example.org",
      book: {}, db: fakeFirebaseFirestore, auth: mockFirebaseAuth,
      storage: mockFirebaseStorage,),)));

    await tester.pumpAndSettle();

    expect(find.text("name"), findsOneWidget);
    expect(find.text("author"), findsOneWidget);
    expect(find.text("Gaia"), findsOneWidget);
  });
  
  testWidgets("Tap book card", (WidgetTester tester) async {
    bool darkTheme = false;
    void testChangeTheme() { darkTheme = !darkTheme; }
    mockFirebaseAuth.signInWithEmailAndPassword(email: "email@example.org", password: "password");

    await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(home:
    BookCard(darkTheme: darkTheme, changeTheme: testChangeTheme,
      userPicture: "assets/images/profile.png",bookName: 'name', authorName: 'author',
      imagePath: 'assets/images/book.jpg', location: 'Gaia', renter: "email@example.org",
      book: const {
      'title': 'The test',
      'renter': 'test_user',
      'imagePath': '',
      'genres': ['action', 'comedy'],
      'author': 'test man',
      'location': 'porto'
      },
      db: fakeFirebaseFirestore, auth: mockFirebaseAuth,
      storage: mockFirebaseStorage,),)));

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("book_card_detector")));
    await tester.pumpAndSettle();

    expect(find.byType(BookPage), findsOneWidget);
  });
}