import 'package:app_prototype/database/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class RecoverPassword extends StatefulWidget {
  const RecoverPassword({super.key});

  @override
  State<RecoverPassword> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  TextEditingController? emailController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.down,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    PreferredSize(
                      preferredSize: const Size.fromHeight(kToolbarHeight),
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        leading: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 18,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                        title: const Text(
                          'Recover Password',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        centerTitle: true,
                        scrolledUnderElevation: 0.0,
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 15.0),
                          child: Text(
                            'Enter your registered email below to receive reset password email.',
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.grey.shade700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: Colors.grey.shade700,
                                        width: 1)),
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.email,
                                        size: 16, color: Colors.black),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        controller: emailController,
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                        cursorColor: Colors.white,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Enter your email',
                                          hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade700),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  autofocus: true,
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        const Color(0xFF474747)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        )),
                                  ),
                                  onPressed: () {
                                    sendEmail();
                                  },
                                  child: const SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        'Reset password',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white),
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
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sendEmail() async {
    String? emailResetPassword = emailController?.text;
    if (emailResetPassword == null) {
      _scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text('Email does not exist.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      bool emailExists = await checkIfEmailExists(FirebaseFirestore.instance,emailResetPassword);
      if (emailExists) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailResetPassword);
        _scaffoldMessengerKey.currentState!.showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        _scaffoldMessengerKey.currentState!.showSnackBar(
          const SnackBar(
            content: Text('Email does not exist.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      _scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
