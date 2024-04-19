import 'package:app_prototype/pages/book_list_page.dart';
import 'package:app_prototype/pages/search_page.dart';
import 'package:app_prototype/widgets/books/book_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Display default page layout', (WidgetTester tester) async {
    bool darkTheme = false;
    void testChangeTheme() { darkTheme = !darkTheme; }
    await tester.pumpWidget(MaterialApp(
        home: BookListPage(changeTheme: testChangeTheme, darkTheme: darkTheme,)));

    expect(find.byType(SearchBar), findsOneWidget);
    expect(find.byKey(const Key("dark_mode_button")), findsOneWidget);
    expect(find.byType(BookList), findsOneWidget);
  });

  testWidgets('Change to Search Page', (WidgetTester tester) async {
    bool darkTheme = false;
    void testChangeTheme() { darkTheme = !darkTheme; }
    await tester.pumpWidget(MaterialApp(
        home: BookListPage(changeTheme: testChangeTheme, darkTheme: darkTheme,)));

    await tester.tap(find.byType(SearchBar));
    await tester.pumpAndSettle();

    expect(find.byType(SearchPage), findsOneWidget);
  });
}
