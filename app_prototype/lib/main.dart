import 'package:app_prototype/login/sign_in_page.dart';
import 'package:app_prototype/pages/add_book_page.dart';
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
  bool logedIn = false;
  
  void changeTheme() {
    setState(() {
      widget.darkTheme = !widget.darkTheme;
    });
  }

  /// Navbar
  @override
  Widget build(BuildContext context) {

    if (!logedIn) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.getTheme(widget.darkTheme),
        home: SignInPage(onSignIn: () {
          setState(() {
            logedIn = true;
          });
        }),
        title: "Lend and Rent (Prototype)",
      );
    }

    // Define your navigation destinations
    List<Menu> destinations = [
      Menu(
        icon: FontAwesomeIcons.house,
        label: 'Books',
        destination: BookListPage(changeTheme: changeTheme, darkTheme: widget.darkTheme),
      ),
      Menu(
        icon: FontAwesomeIcons.user,
        label: 'Profile',
        destination: ProfilePage(changeTheme: changeTheme, darkTheme: widget.darkTheme),
      ),
      // Two Examples to remove later
    Menu(
        icon: FontAwesomeIcons.heart,
        label: 'Favorites',
        destination: null,
      ),
      Menu(
        icon: FontAwesomeIcons.plus,
        label: 'Search',
        destination: AddBookPage(),
      ),
      // Add more destinations as needed
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.getTheme(widget.darkTheme),
      home: MenuNavBarController(changeTheme: changeTheme, darkTheme: widget.darkTheme,destinations: destinations), // Use the NavigationBar widget
      title: "Lend and Rent (Prototype)",
    );
  }
}
