import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/reusable_login.dart';

class Sosmedkosong extends StatelessWidget {
  const Sosmedkosong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset("assets/images/peony.jpeg"),
            HomeButton(
              sosmed: "Back",
              warnaBox: Color(0xFF062592),
              loginSize: 15,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
