import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Menu {
  final IconData icon;
  final String label;
  final Widget? destination;

  Menu({
    required this.icon,
    required this.label,
    required this.destination,
  });
}

class MenuNavBarController extends StatefulWidget {
  final List<Menu> destinations;
  final VoidCallback changeTheme;
  final bool darkTheme;

  const MenuNavBarController({
    Key? key,
    required this.changeTheme,
    required this.darkTheme,
    required this.destinations,
  }) : super(key: key);

  @override
  _MenuBarNavState createState() => _MenuBarNavState();
}

class _MenuBarNavState extends State<MenuNavBarController> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Content behind the bottom navigation bar
          IndexedStack(
            index: _selectedIndex,
            children: widget.destinations
                .map((destination) => destination.destination ?? Container())
                .toList(),
          ),
          // Bottom navigation bar
          Positioned(
            left: 15,
            right: 15,
            bottom: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                color: widget.darkTheme ? Colors.grey.shade900 : Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
                  child: GNav(
                    gap: 12,
                    iconSize: 20,
                    textSize: 25,
                    padding: EdgeInsets.all(16),
                    backgroundColor:
                    widget.darkTheme ? Colors.grey.shade900 : Colors.white,
                    color: widget.darkTheme ? Colors.white : Colors.black,
                    activeColor: widget.darkTheme ? Colors.white : Colors.black,
                    tabBackgroundColor: widget.darkTheme
                        ? Colors.grey.shade800
                        : Colors.grey.shade300,
                    tabs: getMappingList(widget.destinations),
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<GButton> getMappingList(List<Menu> destinations) {
    List<GButton> returnButtons = [];
    for (int i = 0; i < destinations.length; i++) {
      returnButtons.add(GButton(
        icon: destinations[i].icon,
        text: destinations[i].label,
      ));
    }
    return returnButtons;
  }
}
