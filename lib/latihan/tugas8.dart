import 'package:flutter/material.dart';

class BotNavBar extends StatelessWidget {
  const BotNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,

      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.details), label: "TnC"),

        BottomNavigationBarItem(icon: Icon(Icons.event), label: "New Event"),

        BottomNavigationBarItem(icon: Icon(Icons.done), label: "Final page"),
      ],
    );
  }
}
