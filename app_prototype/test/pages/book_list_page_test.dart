import 'package:app_prototype/pages/book_list_page.dart';
import 'package:app_prototype/pages/search_page.dart';
import 'package:app_prototype/widgets/books/book_list.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final MockFirebaseStorage mockFirebaseStorage = MockFirebaseStorage();

  testWidgets('Display default page layout', (WidgetTester tester) async {
    bool darkTheme = false;
    void testChangeTheme() { darkTheme = !darkTheme; }
    await tester.pumpWidget(MaterialApp(
        home: BookListPage(changeTheme: testChangeTheme, darkTheme: darkTheme,
              db: fakeFirebaseFirestore, auth: mockFirebaseAuth, storage: mockFirebaseStorage,)));

    expect(find.byType(SearchBar), findsOneWidget);
    expect(find.byKey(const Key("dark_mode_button")), findsOneWidget);
    expect(find.byType(BookList), findsOneWidget);
  });

  testWidgets('Change to Search Page', (WidgetTester tester) async {
    bool darkTheme = false;
    void testChangeTheme() { darkTheme = !darkTheme; }
    await tester.pumpWidget(MaterialApp(
        home: BookListPage(changeTheme: testChangeTheme, darkTheme: darkTheme,
            db: fakeFirebaseFirestore, auth: mockFirebaseAuth, storage: mockFirebaseStorage,)));

    await tester.tap(find.byType(SearchBar));
    await tester.pumpAndSettle();

    expect(find.byType(SearchPage), findsOneWidget);
  });
}
