import 'package:app_prototype/pages/book_list_page.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({super.key});

  @override
  State<StatefulWidget> createState() => LoginButtonState();
}

class LoginButtonState extends State<LoginButton> {

  void _onPressed() {
    setState(() {
      Navigator.push(context, MaterialPageRoute
        (builder: (context) { return const BookListPage(); }));
    });
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: _onPressed, child: const Text("Login"));
  }
}