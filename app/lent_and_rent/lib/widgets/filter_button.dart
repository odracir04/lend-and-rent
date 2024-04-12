import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({super.key, required this.text});

  final String text;

  @override
  State<StatefulWidget> createState() => FilterButtonState();
}

class FilterButtonState extends State<FilterButton> {

  bool isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  void _onPressed() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  Color _getButtonColor(Set<MaterialState> states) {
    if (isSelected) {
      return const Color.fromRGBO(71, 71, 71, 1);
    }
    else {
      return const Color.fromRGBO(217, 217, 217, 1);
    }
  }

  TextStyle _getTextStyle(Set<MaterialState> states) {
    if (isSelected) {
      return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(217, 217, 217, 1)
      );
    } else {
      return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(47, 47, 47, 1)
      );
    }
  }

  Color _getTextColor(Set<MaterialState> states) {
    if (isSelected) {
      return const Color.fromRGBO(217, 217, 217, 1);
    } else {
      return const Color.fromRGBO(47, 47, 47, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
      return ElevatedButton(
          onPressed: _onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(_getButtonColor),
            textStyle: MaterialStateProperty.resolveWith(_getTextStyle),
            foregroundColor: MaterialStateProperty.resolveWith(_getTextColor),
          ),
          child: Text(widget.text));
  }

}