import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/day15mainpage.dart';
import 'package:latihan_flutter_b6/latihan/day19/database/preference_handler.dart';
import 'package:latihan_flutter_b6/latihan/tugas10_pendaftaran.dart';

class SplashScreenDay19 extends StatefulWidget {
  const SplashScreenDay19({super.key});

  @override
  State<SplashScreenDay19> createState() => _SplashScreenDay19State();
}

class _SplashScreenDay19State extends State<SplashScreenDay19> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 3));
    print("STATUS LOGIN:");
    print(PreferenceHandler.isLogin);
    if (!mounted) return;
    if (PreferenceHandler.isLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPageDay15(isSwitch: false)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Tugas10Pendaftaran()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/images/images03.png"),

          // kIsWeb
          //     ? SizedBox(
          //         width: MediaQuery.of(context).size.width > 1000
          //             ? 500
          //             : double.infinity,
          //         child: TextField(),
          //       )
          //     : TextField(),
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => Tugas10Pendaftaran()),
          //     );
          //   },
          //   child: Text("Ke halaman login"),
          // ),
        ],
      ),
    );
  }
}
