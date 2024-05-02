import 'package:app_prototype/widgets/books/book_card.dart';
import 'package:app_prototype/widgets/users/user_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Basic BookCard structure", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home:
    BookCard(bookName: 'name', authorName: 'author',
      imagePath: 'assets/images/book.jpg', location: 'Gaia', renter: "email@example.org",),));

    expect(find.byType(Stack), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(ClipRRect), findsOneWidget);
    expect(find.byType(Positioned), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(2));
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(UserIcon), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));
  });

  testWidgets("BookCard text", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home:
    BookCard(bookName: 'name', authorName: 'author',
      imagePath: 'assets/images/book.jpg', location: 'Gaia', renter: "email@example.org",),));

    expect(find.text("name"), findsOneWidget);
    expect(find.text("author"), findsOneWidget);
    expect(find.text("Gaia"), findsOneWidget);
  });
}