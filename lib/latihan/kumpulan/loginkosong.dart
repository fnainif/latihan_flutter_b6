import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/kumpulan/reusable_login.dart';

class Loginkosong extends StatelessWidget {
  const Loginkosong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 161, 233),
      body: Column(
        children: [
          SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset("assets/images/peony.jpeg", height: 200),
          ),
          SizedBox(height: 20),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(100, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Kinday",
                        style: TextStyle(
                          fontSize: 50,
                          color: const Color.fromARGB(255, 83, 43, 63),
                        ),
                      ),
                      Text(
                        "Deskripsi",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 83, 43, 63),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Created by",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 83, 43, 63),
                        ),
                      ),
                      Text(
                        "Farida Nur Aini",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 83, 43, 63),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Version : 1.0",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 83, 43, 63),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          HomeButton(
            sosmed: "Back",
            warnaBox: const Color.fromARGB(255, 83, 43, 63),
            loginSize: 15,
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
