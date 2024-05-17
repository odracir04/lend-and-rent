import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_prototype/database/users.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Color changeColor(bool b) {
    if (b) return Colors.red;
    else return Color(0xFF474747);
  }
  late TextEditingController _firstNameController = TextEditingController();
  late TextEditingController _lastNameController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  late TextEditingController _confirmPasswordController = TextEditingController();
  bool? _termsOfService = false;
  bool showPassword = false;
  bool showCheckPassword = false;
  bool wrong1 = false, wrong2 = false, wrong3 = false, wrong4 = false, wrong5 = false, notos = false;

  Future<void> _signUp(BuildContext context) async {
    wrong1 = false;
    wrong2 = false;
    wrong3 = false;
    wrong4 = false;
    wrong5 = false;
    notos = false;
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to sign up: One or more fields are empty.'),
            backgroundColor: Colors.white,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF474747),
                  foregroundColor: Colors.white,
                ),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      setState(() {
        wrong1 = _firstNameController.text.isEmpty;
        wrong2 = _lastNameController.text.isEmpty;
        wrong3 = _emailController.text.isEmpty;
        wrong4 = _passwordController.text.isEmpty;
        wrong5 = _confirmPasswordController.text.isEmpty;
      });
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to sign up: \'Password\' and \'Confirm Password\' fields do not match.'),
            backgroundColor: Colors.white,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF474747),
                  foregroundColor: Colors.white,
                ),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      setState(() {
        wrong4 = true;
        wrong5 = true;
      });
      return;
    }

    if (!_termsOfService!) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to sign up: Please accept the Terms of Service and Privacy Policy.'),
            backgroundColor: Colors.white,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF474747),
                  foregroundColor: Colors.white,
                ),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      setState(() {
        notos = true;
      });
      return;
    }

    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Future<bool> createUserInFirestore = createUserRecord(FirebaseFirestore.instance, FirebaseStorage.instance, _emailController.text,_firstNameController.text, _lastNameController.text);
      bool checkFirestore = await createUserInFirestore;
      if (checkFirestore) {
        print('User signed up: ${userCredential.user!.uid}');
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sign Up Successful'),
              content: Text(
                  'Your sign in was successful, please enjoy the app.'),
              backgroundColor: Colors.white,
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF474747),
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
      }
      else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to sign up.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error signing up: $error');
      if (error.hashCode == 136609402) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to sign up: Email already in use.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar:AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 18,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/LendAndRentLogo1.jpg",
                      width: 300,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      labelStyle: TextStyle(
                          color: changeColor(wrong1)
                      ),
                      hintText: 'Enter your first name',
                      hintStyle: TextStyle(
                          color: changeColor(wrong1)
                      ),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: changeColor(wrong1),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: changeColor(wrong1),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: TextStyle(
                          color: changeColor(wrong2)
                      ),
                      hintText: 'Enter your last name',
                      hintStyle: TextStyle(
                          color: changeColor(wrong2)
                      ),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: changeColor(wrong2),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: changeColor(wrong2),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: changeColor(wrong3)
                      ),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(
                          color: changeColor(wrong3)
                      ),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: changeColor(wrong3),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: changeColor(wrong3),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: changeColor(wrong4)
                      ),
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(
                          color: changeColor(wrong4)
                      ),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: changeColor(wrong4),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: changeColor(wrong4),),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          !showPassword ? Icons.visibility : Icons.visibility_off,
                          color: changeColor(wrong4),
                        ),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !showCheckPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                          color: changeColor(wrong5)
                      ),
                      hintText: 'Enter your password again',
                      hintStyle: TextStyle(
                          color: changeColor(wrong5)
                      ),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: changeColor(wrong5),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: changeColor(wrong5),),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          !showCheckPassword ? Icons.visibility : Icons.visibility_off,
                          color: changeColor(wrong5),
                        ),
                        onPressed: () {
                          setState(() {
                            showCheckPassword = !showCheckPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 3,
                    color: Colors.transparent,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _termsOfService ?? true,
                        onChanged: (newValue) {
                          setState(() => _termsOfService = newValue);
                        },
                      ),
                      Text(
                        'I\'ve read and agreed to the Terms of\n Service and the Privacy Policy',
                        textAlign: TextAlign.start,
                        maxLines: 2,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _signUp(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF474747),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      );
    }
}

