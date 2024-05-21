import 'package:app_prototype/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Theme test", (WidgetTester tester) async {
    ThemeData theme = Themes.getTheme(false);

    expect(theme.primaryColor, Colors.grey.shade400);
    expect(theme.brightness, Brightness.light);
    expect(theme.scaffoldBackgroundColor, Colors.white70);
    expect(theme.cardColor, Colors.grey.shade200);

    theme = Themes.getTheme(true);

    expect(theme.primaryColor, Colors.black);
    expect(theme.brightness, Brightness.dark);
    expect(theme.scaffoldBackgroundColor, Colors.black12);
    expect(theme.cardColor, Colors.grey.shade800);
  });
}