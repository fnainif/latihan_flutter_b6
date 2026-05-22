import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/loginkosong.dart';
import 'package:latihan_flutter_b6/latihan/tugas7_home.dart';
import 'package:latihan_flutter_b6/latihan/tugas7_snk.dart';
import 'package:latihan_flutter_b6/latihan/tugas8.dart';

class MainPageDay15 extends StatefulWidget {
  const MainPageDay15({
    super.key,
    this.initialIndex = 0,
    required this.isSwitch,
  });

  final int initialIndex;
  final bool isSwitch;
  @override
  State<MainPageDay15> createState() => _MainPageDay15State();
}

class _MainPageDay15State extends State<MainPageDay15> {
  late int selectedIndex;
  late bool isSwitch;

  @override
  void initState() {
    super.initState();

    selectedIndex = widget.initialIndex;
    isSwitch = widget.isSwitch;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      Tugas7snk(isSwitch: isSwitch),
      TugasDay15(isSwitch: isSwitch),
      Loginkosong(),
    ];
    return Scaffold(
      body: pages[selectedIndex],

      bottomNavigationBar: BotNavBar(
        selectedIndex: selectedIndex,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
