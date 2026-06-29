import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/kumpulan/tugas10_typage.dart';

class Tugas10Wrong extends StatefulWidget {
  const Tugas10Wrong({super.key});

  @override
  State<Tugas10Wrong> createState() => _Tugas10WrongState();
}

class _Tugas10WrongState extends State<Tugas10Wrong> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nohpController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController instansiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Masukan Nama",
                  labelText: "Nama",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Input tidak boleh kosong';
                  }
                  return null;
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Masukan Email",
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Input tidak boleh kosong';
                  }
                  if (!value.contains("@")) {
                    return "Email harus mengandung @";
                  }
                  return null;
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: nohpController,
                decoration: InputDecoration(
                  hintText: "Masukan No yang bisa dihubungi",
                  labelText: "No. HP",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: "Masukan Alamat",
                  labelText: "Alamat",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Input tidak boleh kosong';
                  }
                  return null;
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: instansiController,
                decoration: InputDecoration(
                  hintText: "Nama Instansi",
                  labelText: "Instansi",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Input tidak boleh kosong';
                  }
                  return null;
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Tugas10HalamanTerimaKasih(
                      nama: nameController.text,
                      namainstansi: instansiController.text,
                    ),
                  ),
                );
              },
              child: Text("Daftar"),
            ),
          ],
        ),
      ),
    );
  }
}
