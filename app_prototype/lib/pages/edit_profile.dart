import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../database/users.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key, required this.changeTheme, required this.darkTheme, required this.userEmail});

  final String userEmail;
  final VoidCallback changeTheme;
  bool darkTheme;
  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
  @override
  _EditProfilePage createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  bool displayEmailInProfile = false;
  TextEditingController? emailController = TextEditingController();
  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? lastNameController = TextEditingController();
  TextEditingController? locationController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  bool init = false;
  String? profile_url;
  dynamic profile_picture;

  Future<bool> setUserData() async {
    if (!init) {
      Future<String?> firstName = getFirstName(FirebaseFirestore.instance,widget.userEmail);
      Future<String?> lastName = getLastName(FirebaseFirestore.instance,widget.userEmail);
      Future<String?> location = getLocation(FirebaseFirestore.instance,widget.userEmail);
      Future<bool?> displayEmail = getDisplayEmail(FirebaseFirestore.instance,widget.userEmail);
      profile_url = await (getPictureUrl(FirebaseFirestore.instance,widget.userEmail));
      if (profile_url == "assets/images/profile.png"){
        profile_picture = AssetImage(profile_url!);
      }
      else{
        profile_picture = NetworkImage(profile_url!);
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
                                backgroundImage: profile_picture,
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
                                      obscureText: true,
                                      controller: passwordController,
                                      style: TextStyle(fontSize: 16, color: widget.darkTheme ? Colors.white : Colors.black),
                                      cursorColor: Colors.white,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter a new password',
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
                                      activeTrackColor: Color(0xFF474747),
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
                                  backgroundColor: MaterialStateProperty.all(Color(0xFF474747)),
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
        source: isCamera! ? ImageSource.camera : ImageSource.gallery,
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
            profile_url = downloadUrl;
            profile_picture = NetworkImage(profile_url!);
          });
        }
      }
    }
    else{
      pickedImage = "assets/images/profile.png";
      bool update = await updateProfilePicture(FirebaseFirestore.instance, widget.userEmail, pickedImage);
      if (update) {
        setState(() {
          profile_picture = AssetImage(pickedImage);
        });
      }

    }
  }


  void saveChangesController() async {

    Future<String?> firstNameFuture = getFirstName(FirebaseFirestore.instance,widget.userEmail);
    Future<String?> lastNameFuture = getLastName(FirebaseFirestore.instance,widget.userEmail);
    Future<String?> locationFuture = getLocation(FirebaseFirestore.instance,widget.userEmail);
    Future<bool?> displayEmailFuture = getDisplayEmail(FirebaseFirestore.instance,widget.userEmail);

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
      await updateUserFirstName(FirebaseFirestore.instance,widget.userEmail, newFirstName);
    }
    if (lastNameUpdated) {
      await updateUserLastName(FirebaseFirestore.instance,widget.userEmail, newLastName);
    }
    if (locationUpdated) {
      await updateUserLocation(FirebaseFirestore.instance,widget.userEmail, newLocation);
    }
    if (displayEmailUpdated) {
      await updateDisplayEmail(FirebaseFirestore.instance,widget.userEmail, newDisplayEmail);
    }
    if (newPassword != ""){
      await updatePassword(widget.userEmail, newPassword);
      passwordUpdated = true;
    }
    else{
      passwordUpdated = false;
    }

    if (firstNameUpdated || lastNameUpdated || locationUpdated || passwordUpdated || displayEmailUpdated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Success updating profile!', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
            backgroundColor: Colors.green
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error updating profile!', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
            backgroundColor: Colors.red
        ),
      );

    }
  }
}
