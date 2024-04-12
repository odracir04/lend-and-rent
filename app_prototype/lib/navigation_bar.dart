import 'package:flutter/material.dart';

class Menu {
  final Icon icon;
  final String label;
  final Widget destination;

  Menu({
    required this.icon,
    required this.label,
    required this.destination,
  });
}

class MenuBarNav extends StatefulWidget {
  final List<Menu> destinations;

  const MenuBarNav({
    Key? key,
    required this.destinations,
  }) : super(key: key);

  @override
  _MenuBarNavState createState() => _MenuBarNavState();
}

class _MenuBarNavState extends State<MenuBarNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.destinations[_selectedIndex].destination,
      bottomNavigationBar: BottomNavigationBar(
        items: widget.destinations.map((destination) {
          return BottomNavigationBarItem(
            icon: destination.icon,
            label: destination.label,
          );
        }).toList(),
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        elevation: 8.0,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
