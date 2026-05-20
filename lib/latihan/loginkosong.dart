import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/reusable_login.dart';

class Loginkosong extends StatelessWidget {
  const Loginkosong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/images/book2.png"),
          HomeButton(
            sosmed: "Back",
            warnaBox: Color(0xFF062592),
            loginSize: 15,
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
