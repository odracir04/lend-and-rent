import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app_prototype/pages/book_list_page.dart'; // Import your book list page
import 'package:app_prototype/themes/theme.dart';
import 'firebase_options.dart';
import 'navigation_bar.dart'; // Import the NavigationBar widget
import 'package:app_prototype/pages/profile_page.dart'; // Import the Profile widget

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}

class App extends StatefulWidget {
  App({Key? key});

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

  /// Navbar
  @override
  Widget build(BuildContext context) {
    // Define your navigation destinations
    List<Menu> destinations = [
      Menu(
        icon: Icon(FontAwesomeIcons.book),
        label: 'Books',
        destination: BookListPage(changeTheme: changeTheme, darkTheme: widget.darkTheme),
      ),
      Menu(
        icon: Icon(FontAwesomeIcons.user),
        label: 'Profile',
        destination: ProfilePage(changeTheme: changeTheme, darkTheme: widget.darkTheme),
      )
      // Add more destinations as needed
    ];

    return MaterialApp(
      theme: Themes.getTheme(widget.darkTheme),
      home: MenuBarNav(destinations: destinations), // Use the NavigationBar widget
      title: "Lend and Rent (Prototype)",
    );
  }
}
