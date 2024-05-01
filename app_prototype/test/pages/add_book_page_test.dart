import 'package:app_prototype/navigation_bar.dart';
import 'package:app_prototype/pages/add_book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Change to AddBookPage', (WidgetTester tester) async {
    bool darkTheme = false;
    void testChangeTheme() { darkTheme = !darkTheme; }
    List<Menu> destinations = [];
    await tester.pumpWidget(MaterialApp(
        home: MenuNavBarController(changeTheme: testChangeTheme, darkTheme: darkTheme, destinations: destinations)));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.byType(AddBookPage), findsOneWidget);
  });

  testWidgets('Add book button does nothing because fields are empty', (WidgetTester tester) async {
    bool darkTheme = false;
    await tester.pumpWidget(MaterialApp(
        home: AddBookPage(darkTheme: darkTheme,)));

    await tester.tap(find.text('Add book'));
    expect(find.byType(AddBookPage), findsOneWidget);
  });
}