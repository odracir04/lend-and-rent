import 'package:app_prototype/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Basic Book List", (WidgetTester tester) async {
    // this test does nothing...
    await tester.pumpWidget(App());
    await tester.pumpAndSettle();
  });
}