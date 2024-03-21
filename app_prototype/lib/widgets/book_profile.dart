import 'package:flutter/material.dart';

class BookProfile extends StatelessWidget {
  const BookProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Row(
          children: [
            Image.asset("assets/images/book.jpg", height: 100, width: 100,),
            const Column(
              children: [
                Text("Book Name"),
                Text("Book Author")
              ],
            )
          ],
        ));
  }

}