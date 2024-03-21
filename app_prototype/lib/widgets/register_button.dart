import 'package:flutter/material.dart';

import '../pages/book_list_page.dart';

class RegisterButton extends StatefulWidget {
  const RegisterButton({super.key});

  @override
  State<StatefulWidget> createState() => RegisterButtonState();
}

class RegisterButtonState extends State<RegisterButton> {

  void _onPressed() {
    setState(() {
      Navigator.push(context, MaterialPageRoute
        (builder: (context) { return const BookListPage(); }));
    });
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: _onPressed, child: const Text("Register"));
  }
}