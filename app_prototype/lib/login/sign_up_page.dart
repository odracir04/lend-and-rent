import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  bool? _checkboxValue = false;
  bool wrong1 = false, wrong2 = false, wrong3 = false, wrong4 = false, wrong5 = false;

  Future<void> _signUp(BuildContext context) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('User signed up: ${userCredential.user!.uid}');
      Navigator.pop(context);
    } catch (error) {
      print('Error signing up: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
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
                      "assets/images/book.jpg",
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
                    obscureText: true,
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
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
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
                        value: _checkboxValue ?? true,
                        onChanged: (newValue) {
                          setState(() => _checkboxValue = newValue);
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
                      'Sign in',
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

