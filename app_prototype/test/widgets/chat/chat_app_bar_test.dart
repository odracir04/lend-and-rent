import 'package:app_prototype/widgets/chat/chat_app_bar.dart';
import 'package:app_prototype/widgets/users/user_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets("Chat App Bar structure", (WidgetTester tester) async {
    await mockNetworkImagesFor(() =>
    tester.pumpWidget(MaterialApp(home:
    ChatAppBar( visitingEmail: "pkwdk",userLocation: "Testland",
      userName: "TestUser", changeTheme: () {}, darkTheme: true, userPicture: "test.jpg",))));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(UserIcon), findsOneWidget);
    expect(find.text("Testland"), findsOneWidget);
    expect(find.text("TestUser"), findsOneWidget);
  });
}