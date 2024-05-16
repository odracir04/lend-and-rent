import 'package:app_prototype/pages/book_list_page.dart';
import 'package:app_prototype/pages/search_page.dart';
import 'package:app_prototype/widgets/books/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Search page", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: SearchPage(darkTheme: false,)));
    expect(find.byType(SearchBar), findsOneWidget);
    expect(find.byType(BookCard), findsNothing);
  });

  testWidgets("Tap filter button", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: SearchPage(darkTheme: false,)));

    await tester.tap(find.byIcon(Icons.filter_list));
    await tester.pump();
    expect(find.text('Filters'), findsOne);
  });

  testWidgets("Tap back button", (WidgetTester tester) async {
    bool darkTheme = false;
    void testChangeTheme() { darkTheme = !darkTheme; }
    await tester.pumpWidget(MaterialApp(
        home: BookListPage(changeTheme: testChangeTheme, darkTheme: darkTheme,)));

    await tester.tap(find.byType(SearchBar));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.byType(BookListPage), findsOneWidget);
  });
}