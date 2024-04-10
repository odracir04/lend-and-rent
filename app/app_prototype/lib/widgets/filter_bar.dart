import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(onPressed: null, child: Text("Most Recent")),
        ElevatedButton(onPressed: null, child: Text("Most Popular")),
        ElevatedButton(onPressed: null, child: Text("Other Filters"))
      ],
    );
  }

}