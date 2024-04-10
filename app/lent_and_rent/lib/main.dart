import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'pages/book_list_page.dart';
import 'themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {

  bool darkTheme = false;

  void changeTheme() {
    setState(() {
      darkTheme = !darkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.getTheme(darkTheme),
      home: BookListPage(changeTheme: changeTheme, darkTheme: darkTheme,),
      title: "Lend and Rent (Prototype)",
    );
  }
}