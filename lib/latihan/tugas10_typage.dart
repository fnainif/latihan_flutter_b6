import 'package:flutter/material.dart';

class Tugas10HalamanTerimaKasih extends StatelessWidget {
  const Tugas10HalamanTerimaKasih({
    super.key,
    required this.nama,
    required this.namainstansi,
  });
  final String nama;
  final String namainstansi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Terima kasih, $nama dari $namainstansi telah mendaftar"),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
