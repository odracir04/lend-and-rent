import 'package:app_prototype/login/sign_in_page.dart';
import 'package:app_prototype/main.dart';
import 'package:app_prototype/pages/edit_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_prototype/database/users.dart';
import 'package:app_prototype/widgets/users/my_review_list.dart';
import '../widgets/users/my_book_list.dart';

/// Profile page -> User can see image, name, email (on/off).
/// On the profile page there are 2 sub menus - one for reviews and other for the books
/// that the user is selling
/// Profile email is the email on the profile.
/// User email is the actual login email.

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.changeTheme,
    required this.darkTheme,
    required this.profileEmail,
  });

  final VoidCallback changeTheme;
  final String profileEmail;
  final bool darkTheme;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool accessToFunctionalities = false;
  int selectedTabIndex = 0;
  String? userEmail;
  String? _firstName;
  String? _lastName;
  String? _location;
  bool? _displayEmail;
  String? userName;
  String? profileUrl;
  dynamic profilePicture;

  Future<void> setUserData() async {
    userEmail = FirebaseAuth.instance.currentUser!.email!;
    Future<String?> firstName = getFirstName(FirebaseFirestore.instance, widget.profileEmail);
    Future<String?> lastName = getLastName(FirebaseFirestore.instance, widget.profileEmail);
    Future<String?> location = getLocation(FirebaseFirestore.instance, widget.profileEmail);
    Future<bool?> displayEmail = getDisplayEmail(FirebaseFirestore.instance, widget.profileEmail);
    profileUrl = await (getPictureUrl(FirebaseFirestore.instance,widget.profileEmail));


    if (profileUrl == "assets/images/profile.png"){
      profilePicture = AssetImage(profileUrl!);
    }
    else{
      profilePicture = NetworkImage(profileUrl!);
    }
    // Get user parameters of the database
    _firstName = (await (firstName));
    _lastName = (await (lastName));
    _location = (await (location));
    _displayEmail = (await (displayEmail));


    userName = assembleName(_firstName, _lastName); // Get full name of the user

    // Can this user edit profile?. When viewing other users profiles the access to this functionalities
    // should be restricted.

    if (widget.profileEmail == userEmail) {
      accessToFunctionalities = true;
    } else {
      accessToFunctionalities = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: setUserData(),
      builder: (context, snapshot) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: widget.darkTheme ? Colors.black : Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppBar(
                      scrolledUnderElevation: 0,
                      backgroundColor: widget.darkTheme ? Colors.black : Colors.white,
                      toolbarHeight: 50.0,
                      centerTitle: true,
                      title: Text(
                        accessToFunctionalities ? 'My profile' : "Profile Page",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                          widget.darkTheme ? Colors.white : Colors.black,
                        ),
                      ),
                      actions: [
                        PopupMenuButton(
                          offset: Offset(0, 40),
                          itemBuilder: (BuildContext context) {
                            List<PopupMenuEntry<String>> items = [];
                            if (accessToFunctionalities) {
                              items.add(
                                PopupMenuItem(
                                  value: 'edit',
                                  child: ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('Edit Profile'),
                                  ),
                                ),
                              );
                              items.add(
                                PopupMenuItem(
                                  value: 'logout',
                                  child: ListTile(
                                    leading: Icon(Icons.logout),
                                    title: Text('Log out'),
                                  ),
                                ),
                              );
                            } else {
                              items.add(
                                PopupMenuItem(
                                  value: 'report',
                                  child: ListTile(
                                    leading: Icon(Icons.report),
                                    title: Text('Report'),
                                  ),
                                ),
                              );
                            }
                            return items;
                          },
                          onSelected: (String value) {
                            switch (value) {
                              case 'edit':
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfilePage(
                                      db: FirebaseFirestore.instance,
                                      auth: FirebaseAuth.instance,
                                      changeTheme: widget.changeTheme,
                                      darkTheme: widget.darkTheme,
                                      userEmail: userEmail ?? "default",
                                    ),
                                  ),
                                ).then((result) {
                                  if (result == true) {
                                    setState(() {
                                      setUserData();
                                    });
                                  }
                                });
                                break;
                              case 'logout':
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Log Out'),
                                      content: Text('Click the button below to log out.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () async {
                                            await FirebaseAuth.instance.signOut();
                                            AppState().loggedIn = false;
                                            Navigator.of(context).pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder: (context) => App(
                                                  db: FirebaseFirestore.instance,
                                                  auth: FirebaseAuth.instance,
                                                ),
                                              ),
                                                  (route) => false,
                                            );
                                          },
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                          ),
                                          child: Text('Log Out'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                break;
                              case 'report':
                                String reportReason = '';
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Report'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Please provide a reason for the report:',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 10),
                                          TextFormField(
                                            onChanged: (value) {
                                              reportReason = value;
                                            },
                                            maxLines: 3,
                                            decoration: InputDecoration(
                                              hintText: 'Enter reason here',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.black,
                                          ),
                                          child: Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            final user = FirebaseAuth.instance.currentUser;
                                            final reportsCollection = FirebaseFirestore.instance.collection('reports');

                                            reportsCollection.add({
                                              'reportedUser': widget.profileEmail,
                                              'reporterUserId': user!.email,
                                              'reason': reportReason,
                                              'timestamp': DateTime.now(),
                                            }).then((_) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Report submitted successfully')),
                                              );
                                            }).catchError((error) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Failed to submit report: $error')),
                                              );
                                            });
                                            Navigator.of(context).pop(); // Close the dialog
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                          ),
                                          child: Text('Send'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                break;
                            }
                          },
                          icon: Icon(
                            Icons.more_vert,
                            size: 18.0,
                            color: widget.darkTheme ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: profilePicture ?? const AssetImage("assets/images/profile.png"),
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      userName ?? "default",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: widget.darkTheme
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.location_on,
                                            size: 12,
                                            color: widget.darkTheme
                                                ? Colors.white
                                                : Colors.black),
                                        const SizedBox(width: 5),
                                        Text(
                                          _location ?? "default",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0,
                                            color: widget.darkTheme
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (_displayEmail ?? false)
                                      Row(
                                        children: [
                                          const SizedBox(width: 20),
                                          Icon(
                                            Icons.email,
                                            size: 12.0,
                                            color: widget.darkTheme
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            widget.profileEmail,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0,
                                              color: widget.darkTheme
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => changeProfileMenu(0),
                      child: Container(
                        color: widget.darkTheme ? Colors.black : Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const IconButton(
                              onPressed: null,
                              icon: Icon(Icons.book, size: 18),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 2,
                              color: selectedTabIndex == 0
                                  ? (widget.darkTheme
                                  ? Colors.white
                                  : Colors.black)
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => changeProfileMenu(1),
                      child: Container(
                        color: widget.darkTheme ? Colors.black : Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const IconButton(
                              onPressed: null,
                              icon: Icon(Icons.star, size: 18),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 2,
                              color: selectedTabIndex == 1
                                  ? (widget.darkTheme
                                  ? Colors.white
                                  : Colors.black)
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 8,
                child: (selectedTabIndex == 0)
                // User books
                    ? Container(
                  color: widget.darkTheme ? Colors.black : Colors.white,
                  child: MyBookList(
                    visitingEmail: widget.profileEmail,
                    userEmail: userEmail ?? "default",
                    darkTheme: widget.darkTheme,
                    changeTheme: widget.changeTheme,
                  ),
                )
                // User reviews
                    : Container(
                  color: widget.darkTheme ? Colors.black : Colors.white,
                  child: MyReviewList(
                    visitingEmail: widget.profileEmail,
                    userEmail: userEmail ?? "default",
                    darkTheme: widget.darkTheme,
                    changeTheme: widget.changeTheme,
                  )
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// This function changes the profile selected in the menu
  /// 0 - Books tab.
  /// 1 - Reviews tab.
  void changeProfileMenu(int tabIndex) {
    if (tabIndex >= 0 && tabIndex <= 1) {
      setState(() {
        if (selectedTabIndex != tabIndex) {
          selectedTabIndex = tabIndex;
        }
      });
    }
  }
}
