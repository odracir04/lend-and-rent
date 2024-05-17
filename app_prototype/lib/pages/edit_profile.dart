import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../database/users.dart';
import '../main.dart';

/// In this page, user can edit his profile including
/// Picture, name, location, password, and displayEmail.
/// Picture is automatically saved on picking image.
/// For the others, it is necessary to click in save changes.

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key, required this.changeTheme, required this.darkTheme, required this.userEmail, required this.db,
                    required this.auth});

  final String userEmail;
  final VoidCallback changeTheme;
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  bool darkTheme;

  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  @override
  State<EditProfilePage> createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  bool displayEmailInProfile = false;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? lastNameController = TextEditingController();
  TextEditingController? locationController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  bool init = false;
  String? profileUrl;
  dynamic profilePicture;
  bool showPassword = false;

  Future<bool> setUserData() async {
    if (!init) {
      Future<String?> firstName = getFirstName(widget.db,widget.userEmail);
      Future<String?> lastName = getLastName(widget.db,widget.userEmail);
      Future<String?> location = getLocation(widget.db,widget.userEmail);
      Future<bool?> displayEmail = getDisplayEmail(widget.db,widget.userEmail);
      profileUrl = await getPictureUrl(widget.db,widget.userEmail);
      // If image is equal to the default
      if (profileUrl == "assets/images/profile.png"){
        profilePicture = AssetImage(profileUrl!);
      }
      else{
        // Else pick downloaded image from database
        profilePicture = NetworkImage(profileUrl!);
      }
      emailController?.text = widget.userEmail;
      firstNameController?.text = (await (firstName))!;
      lastNameController?.text = (await (lastName))!;
      locationController?.text = (await (location))!;
      displayEmailInProfile = (await (displayEmail))!;
      init = true;
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setUserData(),
      builder: (c, k) {
        return Scaffold(
          body: SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
            child: Column(
              children: [
                Container(
                  color: widget.darkTheme ? Colors.black : Colors.white,
                  child: Column(
                    children: [
                      PreferredSize(
                        preferredSize: const Size.fromHeight(kToolbarHeight),
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              size: 18,
                              color: widget.darkTheme ? Colors.white : Colors.black,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                          title: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: widget.darkTheme ? Colors.white : Colors.black,
                            ),
                          ),
                          centerTitle: true,
                          scrolledUnderElevation: 0.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: _pickProfileImage,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profilePicture,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: GestureDetector(
                          onTap: _pickProfileImage,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt, size: 16,  color: widget.darkTheme ? Colors.white : Colors.black),
                              const SizedBox(width: 5),
                              Text(
                                'Edit profile picture',
                                style: TextStyle(
                                  color: widget.darkTheme ? Colors.white: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'First name',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: widget.darkTheme ? Colors.white : Colors.black),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  color: widget.darkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.grey.shade700, width: 1)
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: [
                                  Icon(Icons.person,size: 16, color: widget.darkTheme ? Colors.white : Colors.black),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: firstNameController,
                                      style: TextStyle(fontSize: 16, color: widget.darkTheme ? Colors.white : Colors.black),
                                      cursorColor: Colors.white,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter your first name',
                                        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Last name',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: widget.darkTheme ? Colors.white : Colors.black),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  color: widget.darkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.grey.shade700, width: 1)
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: [
                                  Icon(Icons.person,size: 16, color: widget.darkTheme ? Colors.white : Colors.black),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: lastNameController,
                                      style: TextStyle(fontSize: 16, color: widget.darkTheme ? Colors.white : Colors.black),
                                      cursorColor: Colors.white,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter your last name',
                                        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Location',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: widget.darkTheme ? Colors.white : Colors.black),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  color: widget.darkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.grey.shade700, width: 1)
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on, size: 16, color: widget.darkTheme ? Colors.white : Colors.black),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: locationController,
                                      style: TextStyle(fontSize: 16, color: widget.darkTheme ? Colors.white : Colors.black),
                                      cursorColor: Colors.white,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter your location',
                                        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: widget.darkTheme ? Colors.white : Colors.black),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  color: widget.darkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.grey.shade700, width: 1)
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: [
                                  Icon(Icons.password, size: 16, color: widget.darkTheme ? Colors.white : Colors.black),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      obscureText: !showPassword,
                                      controller: passwordController,
                                      style: TextStyle(fontSize: 16, color: widget.darkTheme ? Colors.white : Colors.black),
                                      cursorColor: Colors.white,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter a new password',
                                        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            !showPassword ? Icons.visibility : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              showPassword = !showPassword;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: widget.darkTheme ? Colors.white : Colors.black),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: widget.darkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.grey.shade700, width: 1),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: [
                                  Icon(Icons.email, size: 16, color: widget.darkTheme ? Colors.white : Colors.black),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      readOnly: true,
                                      canRequestFocus: false,
                                      controller: emailController,
                                      style: TextStyle(fontSize: 16, color: widget.darkTheme ? Colors.white : Colors.black),
                                      cursorColor: Colors.white,
                                    ),
                                  ),
                              const Tooltip(
                                message: "The email field is read-only",
                                child : Icon(Icons.info_outline, color: Color(0xFF474747))
                              ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                  title: Text(
                                    'Display Email in Profile',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: widget.darkTheme ? Colors.white : Colors.black),
                                  ),
                                  trailing:Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      value: displayEmailInProfile,
                                      onChanged: (newValue) {
                                        setState(() {
                                          displayEmailInProfile = newValue;
                                        });
                                      },
                                      activeTrackColor: const Color(0xFF474747),
                                      activeColor: Colors.white,
                                    ),
                                  )

                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                autofocus: true,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(const Color(0xFF474747)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  saveChangesController();
                                },
                                child: const SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Save changes',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                key: const Key("delete_profile_button"),
                                autofocus: true,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Color(0xFF700000)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Delete Profile"),
                                      content: const Text("Are you sure you want to delete your profile?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () { Navigator.of(context).pop(true); },
                                            child: const Text("Yes")
                                        ),
                                        TextButton(
                                            onPressed: () { Navigator.of(context).pop(false); } ,
                                            child: const Text("No"))
                                      ],
                                    );
                                  }).then((value) {
                                    if (value) deleteProfile();
                                  });
                                },
                                child: const SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Delete Profile',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
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
        );
      },
    );
  }

  /// Pick image updates automatically the storage.
  Future<void> _pickProfileImage() async {
    final bool? isCamera = await showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.black),
                title: const Text('Camera', style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20)),
                onTap: () {
                  Navigator.pop(context, true);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.black),
                title: const Text('Gallery', style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20)),
                onTap: () {
                  Navigator.pop(context, false);
                },
              ),
              ListTile(
                leading: const Icon(Icons.remove_circle, color: Colors.black),
                title: const Text('Remove profile image',
                    style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
                onTap: () {
                  Navigator.pop(context, null);
                },
              ),
            ],
          ),
        );
      },
    );

    dynamic pickedImage;
    if (isCamera != null) {
      pickedImage = await ImagePicker().pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
      );
      if (pickedImage != null) {
        String email = widget.userEmail;
        Reference storageRef = FirebaseStorage.instance.ref();
        File file = File(pickedImage.path);
        var snapshot = (await storageRef.child("profiles/$email/picture").putFile(file));
        var downloadUrl = await (snapshot.ref.getDownloadURL());
        bool update = await updateProfilePicture(FirebaseFirestore.instance, email, downloadUrl);
        if (update) {
          setState(() {
            profileUrl = downloadUrl;
            profilePicture = NetworkImage(profileUrl!);
          });
        }
      }
    }
    else{
      // Remove image and set it to default.
      pickedImage = "assets/images/profile.png";
      bool update = await updateProfilePicture(FirebaseFirestore.instance, widget.userEmail, pickedImage);
      if (update) {
        setState(() {
          profileUrl = pickedImage;
          profilePicture = AssetImage(pickedImage);
        });
      }
    }
  }


  void saveChangesController() async {
    Future<String?> firstNameFuture = getFirstName(widget.db,widget.userEmail);
    Future<String?> lastNameFuture = getLastName(widget.db,widget.userEmail);
    Future<String?> locationFuture = getLocation(widget.db,widget.userEmail);
    Future<bool?> displayEmailFuture = getDisplayEmail(widget.db,widget.userEmail);
    Future<String?> displayProfilePicture = getPictureUrl(widget.db,widget.userEmail);

    String? newFirstName = firstNameController!.text;
    String? newLastName = lastNameController!.text;
    String? newLocation = locationController!.text;
    String? newPassword = passwordController!.text;
    bool? newDisplayEmail = displayEmailInProfile;

    String? currentFirstName = await firstNameFuture;
    String? currentLastName = await lastNameFuture;
    String? currentLocation = await locationFuture;
    bool? currentDisplayEmail = await displayEmailFuture;

    bool firstNameUpdated = currentFirstName != newFirstName;
    bool lastNameUpdated = currentLastName != newLastName;
    bool locationUpdated = currentLocation != newLocation;
    bool passwordUpdated;
    bool displayEmailUpdated = currentDisplayEmail != newDisplayEmail;


    if (firstNameUpdated) {
      await updateUserFirstName(widget.db,widget.userEmail, newFirstName);
    }
    if (lastNameUpdated) {
      await updateUserLastName(widget.db,widget.userEmail, newLastName);
    }
    if (locationUpdated) {
      await updateUserLocation(widget.db,widget.userEmail, newLocation);
    }
    if (displayEmailUpdated) {
      await updateDisplayEmail(widget.db,widget.userEmail, newDisplayEmail);
    }
    if (newPassword != ""){
      await updatePassword(widget.userEmail, newPassword);
      passwordUpdated = true;
    }
    else{
      passwordUpdated = false;
    }

    if (firstNameUpdated || lastNameUpdated || locationUpdated || passwordUpdated || displayEmailUpdated) {
      _scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
            content: Text('Success updating profile!', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
            backgroundColor: Colors.green
        ),
      );
    } else {
      _scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Error updating profile!', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
            backgroundColor: Colors.red
        ),
      );

    }
  }

  void deleteProfile() async {
    await widget.auth.currentUser!.delete();
    deleteUser(widget.db, widget.userEmail);
    Navigator.push(context, MaterialPageRoute(builder: (context) => App(db: widget.db, auth: widget.auth,)));
  }
}
