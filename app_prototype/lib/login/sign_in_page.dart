import 'dart:async';

import 'package:app_prototype/login/recover_password.dart';
import 'package:app_prototype/login/sign_up_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatefulWidget {
  final VoidCallback onSignIn;
  final FirebaseAuth auth;
  final FirebaseStorage storage;
  final FirebaseFirestore db;

  SignInPage({required this.onSignIn, required this.auth,
              required this.db, required this.storage});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  Color changeColor(bool b) {
    if (b) return Colors.red;
    else return Color(0xFF474747);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool wrong = false;
  bool showPassword = false;

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential = await widget.auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      widget.onSignIn();
      print('User signed in: ${userCredential.user!.uid}');
      await widget.auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to sign in: Wrong email or password. Please try again.'),
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
        wrong = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                      Image.asset(
                        "assets/images/LendAndRentLogo1.jpg",
                        width: 300,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                  const SizedBox(height: 20),
                  TextFormField(
                    key: const Key('sign_in_email'),
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: changeColor(wrong)
                      ),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(
                          color: changeColor(wrong)
                      ),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: changeColor(wrong),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: changeColor(wrong),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    key: const Key('sign_in_password'),
                    controller: passwordController,
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: changeColor(wrong)
                      ),
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(
                          color: changeColor(wrong)
                      ),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: changeColor(wrong),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: changeColor(wrong),),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          !showPassword ? Icons.visibility : Icons.visibility_off,
                          color: changeColor(wrong),
                        ),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _signInWithEmailAndPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF474747),
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage(auth: widget.auth,
                          db: widget.db, storage: widget.storage,)),
                      );
                      print('Sign up button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF474747),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      print('Recover password button pressed');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecoverPassword()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF474747),
                    ),
                    child: const Text(
                      'Recover password',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
        ),
      ),
    ))));
  }
}


