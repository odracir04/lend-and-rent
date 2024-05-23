import 'package:app_prototype/pages/book_list_page.dart';
import 'package:app_prototype/pages/search_page.dart';
import 'package:app_prototype/widgets/books/book_card.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
  MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  MockFirebaseStorage mockFirebaseStorage = MockFirebaseStorage();

  testWidgets("Search page", (WidgetTester tester) async {

    bool darkTheme = false;
    void testChangeTheme() { darkTheme = !darkTheme; }

    await tester.pumpWidget(MaterialApp(
        home: SearchPage(darkTheme: darkTheme,changeTheme: testChangeTheme,
              db: fakeFirebaseFirestore, auth: mockFirebaseAuth,
              storage: mockFirebaseStorage,)));
    expect(find.byType(SearchBar), findsOneWidget);
    expect(find.byType(BookCard), findsNothing);
  });

  testWidgets("Tap filter button", (WidgetTester tester) async {

    bool darkTheme = false;
    void testChangeTheme() { darkTheme = !darkTheme; }

    await tester.pumpWidget(MaterialApp(
        home: SearchPage(darkTheme: darkTheme, changeTheme: testChangeTheme,
                db: fakeFirebaseFirestore, auth: mockFirebaseAuth,
                storage: mockFirebaseStorage,)));

    await tester.tap(find.byIcon(Icons.filter_list));
    await tester.pump();
    expect(find.text('Filters'), findsOne);
  });

  testWidgets("Tap back button", (WidgetTester tester) async {
    bool darkTheme = false;
    void testChangeTheme() { darkTheme = !darkTheme; }
    await tester.pumpWidget(MaterialApp(
        home: BookListPage(changeTheme: testChangeTheme, darkTheme: darkTheme,
        db: fakeFirebaseFirestore, auth: mockFirebaseAuth, storage: mockFirebaseStorage,)));

    await tester.tap(find.byType(SearchBar));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.byType(BookListPage), findsOneWidget);
  });
}