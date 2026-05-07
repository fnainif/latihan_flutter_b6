import 'package:flutter/material.dart';

class ProfileDay5 extends StatelessWidget {
  const ProfileDay5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 213, 248),
      appBar: AppBar(
        title: Text(
          "Profil Saya",
          style: TextStyle(color: const Color.fromARGB(255, 248, 245, 247)),
        ),
        backgroundColor: const Color.fromARGB(255, 180, 116, 185),
        centerTitle: true,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Farida Nur Aini",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: const Color.fromARGB(255, 145, 67, 121),
              ),
              Text("Jakarta, Indonesia", style: TextStyle(fontSize: 20)),
            ],
          ),

          Text(
            "Seorang mahasiswa yang sedang belajar flutter di PPKD Jakarta Pusat",
            style: TextStyle(
              fontSize: 15,
              color: const Color.fromARGB(255, 170, 123, 156),
            ),
          ),
        ],
      ),
    );
  }
}
