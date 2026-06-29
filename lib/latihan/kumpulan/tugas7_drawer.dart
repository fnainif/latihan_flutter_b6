import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/kumpulan/tugas7_home.dart';
import 'package:latihan_flutter_b6/latihan/kumpulan/tugas7_snk.dart';

class Tugas7Drawer extends StatelessWidget {
  const Tugas7Drawer({
    super.key,
    required this.isSwitch,
    required this.onChanged,
  });

  final bool isSwitch;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/product_watch.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(
              "Tes Header Drawer",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: TosButton(drawer: "Term of Service", isSwitch: isSwitch),
          ),
          ListTile(
            title: FormButton(drawer: "New Event", isSwitch: isSwitch),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Switch(value: isSwitch, onChanged: onChanged),
              SizedBox(width: 10),
              Text(
                isSwitch ? "Dark mode" : "Light mode",
                style: TextStyle(color: const Color.fromARGB(255, 53, 6, 35)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TosButton extends StatelessWidget {
  const TosButton({super.key, required this.drawer, required this.isSwitch});

  final String drawer;
  final bool isSwitch;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Tugas7snk(isSwitch: isSwitch),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          drawer,
          textAlign: TextAlign.center,
          style: TextStyle(color: const Color.fromARGB(255, 53, 6, 35)),
        ),
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  const FormButton({super.key, required this.drawer, required this.isSwitch});

  final String drawer;
  final bool isSwitch;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TugasDay15(isSwitch: isSwitch),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          drawer,
          textAlign: TextAlign.center,
          style: TextStyle(color: const Color.fromARGB(255, 53, 6, 35)),
        ),
      ),
    );
  }
}
