import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<StatefulWidget> createState() => SearchBarState();
}

class SearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: SearchBar(
          padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
          leading: const Icon(Icons.search),
          hintText: "Search for books here...",
          onSubmitted: null,
    ));
  }
}