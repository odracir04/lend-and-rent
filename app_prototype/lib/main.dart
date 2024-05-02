import 'package:app_prototype/login/sign_in_page.dart';
import 'package:app_prototype/pages/chat_list_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
  bool loggedIn = false;
  User? user;

  void changeTheme() {
    setState(() {
      widget.darkTheme = !widget.darkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loggedIn) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.getTheme(widget.darkTheme),
        home: SignInPage(
          onSignIn: () {
            setState(() {
              loggedIn = true;
              user = FirebaseAuth.instance.currentUser;
            });
          },
        ),
        title: "Lend and Rent (Prototype)",
      );
    }

    List<Menu> destinations = [
      Menu(
        icon: Icons.house,
        label: 'Books',
        destination: BookListPage(
          changeTheme: changeTheme,
          darkTheme: widget.darkTheme,
        ),
      ),
      Menu(
        icon: Icons.person,
        label: 'Profile',
        destination: ProfilePage(
          changeTheme: changeTheme,
          darkTheme: widget.darkTheme,
          userEmail: FirebaseAuth.instance.currentUser!.email!,
        ),
      ),
      // Two Examples to remove later
    Menu(
        icon: Icons.message,
        label: 'Chat',
        destination: ChatListPage(userEmail: FirebaseAuth.instance.currentUser!.email!, db: FirebaseFirestore.instance),
      ),

      // Add more destinations as needed
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,

      theme: Themes.getTheme(widget.darkTheme),
      home: MenuNavBarController(
        changeTheme: changeTheme,
        darkTheme: widget.darkTheme,
        destinations: destinations,
      ),
      title: "Lend and Rent (Prototype)",
    );
  }
}
