import 'package:app_prototype/widgets/filter_button.dart';
import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FilterButton(text: "Filter 1"),
        SizedBox(width: 10,),
        FilterButton(text: "Filter 2"),
        SizedBox(width: 10,),
        FilterButton(text: "Other Filters")
      ],
    );
  }
}