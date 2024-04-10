import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
            onPressed: null,
            style: ButtonStyle(
              textStyle: MaterialStatePropertyAll(
                  TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black12)
              ),
            ),
            child: Text("Filter 1")),
        SizedBox(width: 10,),
        ElevatedButton(
            onPressed: null,
            style: ButtonStyle(
              textStyle: MaterialStatePropertyAll(
                  TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black12),
              ),
            ),
            child: Text("Filter 2")),
        SizedBox(width: 10,),
        ElevatedButton(
            onPressed: null,
            style: ButtonStyle(
              textStyle: MaterialStatePropertyAll(
                  TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black12),
              ),
            ),
            child: Text("Other Filters"))
      ],
    );
  }

}