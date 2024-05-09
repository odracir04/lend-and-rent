import 'package:app_prototype/pages/edit_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_prototype/database/users.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key, required this.changeTheme, required this.darkTheme, required this.userEmail}) : super(key: key);

  final VoidCallback changeTheme;
  final String userEmail;
  bool darkTheme;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedTabIndex = 0;
  String? _firstName;
  String? _lastName;
  String? _location;
  bool? _displayEmail;
  String? _profilePictureUrl;
  String? userName;

  Future<bool> setUserData() async {
      Future<String?> firstName = getFirstName(FirebaseFirestore.instance,widget.userEmail);
      Future<String?> lastName = getLastName(FirebaseFirestore.instance,widget.userEmail);
      Future<String?> location = getLocation(FirebaseFirestore.instance,widget.userEmail);
      Future<bool?> displayEmail = getDisplayEmail(FirebaseFirestore.instance,widget.userEmail);
      Future<String?> profilePictureUrl = getProfilePicture(FirebaseFirestore.instance,widget.userEmail);
      _firstName = (await (firstName))!;
      _lastName = (await (lastName))!;
      _location = (await (location))!;
      _displayEmail = (await (displayEmail))!;
      _profilePictureUrl = (await (profilePictureUrl))!;
      userName = assembleName(_firstName, _lastName);
      return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setUserData(),
      builder: (c, k) {
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
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      toolbarHeight: 50.0,
                      centerTitle: true,
                      title: Text(
                        'My profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: widget.darkTheme ? Colors.white : Colors.black,
                        ),
                      ),

                      actions: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 18.0,
                            color: widget.darkTheme ? Colors.white : Colors.black,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfilePage(
                                  changeTheme: widget.changeTheme,
                                  darkTheme: widget.darkTheme,
                                  userEmail: widget.userEmail,
                                  db: FirebaseFirestore.instance,
                                  auth: FirebaseAuth.instance,
                                ),
                              ),
                            ).then((result) {
                              if (result == true) {
                                setState(() {
                                  setUserData();
                                });
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration:  const BoxDecoration(
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
                                  backgroundImage: getProfilePictureFile(_profilePictureUrl),
                                ),
                                const SizedBox(height: 20.0),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      userName!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: widget.darkTheme ? Colors.white : Colors.black,
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
                                        Icon(Icons.location_on, size: 12, color: widget.darkTheme ? Colors.white : Colors.black),
                                        const SizedBox(width: 5),
                                        Text(
                                          _location!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0,
                                            color: widget.darkTheme ? Colors.white : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),

                                    if (_displayEmail!)
                                      Row(
                                        children: [
                                          const SizedBox(width: 20),
                                          Icon(
                                            Icons.email,
                                            size: 12.0,
                                            color: widget.darkTheme ? Colors.white : Colors.black,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            widget.userEmail,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0,
                                              color: widget.darkTheme ? Colors.white : Colors.black,
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
                            IconButton(
                              onPressed: null,
                              icon: Icon(Icons.book, size: 18, color: selectedTabIndex == 0 ? (widget.darkTheme ? Colors.white : Colors.black ) : Colors.grey.shade900),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 2,
                              color: selectedTabIndex == 0 ? (widget.darkTheme ? Colors.white : Colors.black ) : Colors.transparent,
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
                            IconButton(
                              onPressed: null,
                              icon: Icon(Icons.star, size: 18, color: selectedTabIndex == 1 ? (widget.darkTheme ? Colors.white : Colors.black ) : Colors.grey.shade900),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 2,
                              color: selectedTabIndex == 1 ? (widget.darkTheme ? Colors.white : Colors.black ) : Colors.transparent,
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
                    ? Container(
                  color: widget.darkTheme ? Colors.black : Colors.white,
                  child:
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "No books\n currently being read",  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: widget.darkTheme ? Colors.white : Colors.black,
                      ),
                      )
                    )
                ) : Container(
                  color: widget.darkTheme ? Colors.black : Colors.white,
                    child:
                    Center(
                        child: Text(
                          textAlign: TextAlign.center,
                            "No reviews\n posted yet",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: widget.darkTheme ? Colors.white : Colors.black,
                          ),
                        )
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
    if (tabIndex>=0 && tabIndex<=1) {
      setState(() {
        if (selectedTabIndex != tabIndex) {
          selectedTabIndex = tabIndex;
        }
      });
    }
  }


}
