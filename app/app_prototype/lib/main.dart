import 'package:app_prototype/pages/book_list_page.dart';
import 'package:app_prototype/themes/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}

class App extends StatefulWidget {
  App({super.key});

  bool darkTheme = false;

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {

  void changeTheme() {
    setState(() {
      widget.darkTheme = !widget.darkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.getTheme(widget.darkTheme),
      home: BookListPage(changeTheme: changeTheme, darkTheme: widget.darkTheme,),
      title: "Lend and Rent (Prototype)",
    );
  }
}