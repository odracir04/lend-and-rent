import 'package:app_prototype/login/sign_in_page.dart';
import 'package:app_prototype/pages/chat_list_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_prototype/pages/book_list_page.dart';
import 'package:app_prototype/themes/theme.dart';
import 'firebase_options.dart';
import 'navigation_bar.dart';
import 'package:app_prototype/pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App(db: FirebaseFirestore.instance, auth: FirebaseAuth.instance, storage: FirebaseStorage.instance,));
}
class App extends StatefulWidget {
  App({Key? key, required this.db, required this.auth, required this.storage});

  bool darkTheme = false;
  final FirebaseAuth auth;
  final FirebaseFirestore db;
  final FirebaseStorage storage;

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  bool loggedIn = false;
  User? user;

  void initState() {
    super.initState();
    widget.auth.authStateChanges().listen((User? user) {
      setState(() {
        this.user = user;
        this.loggedIn = user != null;
      });
    });
  }

  void changeTheme() {
    setState(() {
      widget.darkTheme = !widget.darkTheme;
    });
  }

  void handleSignIn() {
    setState(() {
      loggedIn = true;
    });
  }

  /// Navbar
  @override
  Widget build(BuildContext context) {
    if (!loggedIn) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.getTheme(widget.darkTheme),
        home: SignInPage(auth: widget.auth, onSignIn: () {
          handleSignIn();
        }, db: widget.db, storage: widget.storage,),
        title: "Lend and Rent (Prototype)",
      );
    }

    List<Menu> destinations = [
      Menu(
        icon: Icons.house,
        label: 'Books',
        destination: BookListPage(
          auth: widget.auth,
          storage: widget.storage,
          db: widget.db,
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
          profileEmail: widget.auth.currentUser!.email!,
          db: widget.db,
          auth: widget.auth,
          storage: widget.storage,
        ),
      ),
      // Two Examples to remove later
    Menu(
        icon: Icons.message,
        label: 'Chat',
        destination: ChatListPage(changeTheme: changeTheme, darkTheme: widget.darkTheme,
            userEmail: widget.auth.currentUser!.email!, db: widget.db,
            auth: widget.auth, storage: widget.storage,),
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
