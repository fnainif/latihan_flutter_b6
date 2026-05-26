import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/reusable_login.dart';
import 'package:latihan_flutter_b6/latihan/tugas10_typage.dart';

class Tugas10Pendaftaran extends StatefulWidget {
  const Tugas10Pendaftaran({super.key});

  @override
  State<Tugas10Pendaftaran> createState() => _Tugas10PendaftaranState();
}

class _Tugas10PendaftaranState extends State<Tugas10Pendaftaran> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nohpController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController instansiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF011B33),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 355,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 217, 217, 217),
                image: DecorationImage(
                  image: AssetImage("assets/images/product_heels.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 40,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Welcome back to Estero. Have a good time",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: nameController,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 217, 217, 217),
                            ),
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
                            style: TextStyle(
                              color: const Color.fromARGB(255, 217, 217, 217),
                            ),
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
                            style: TextStyle(
                              color: const Color.fromARGB(255, 217, 217, 217),
                            ),
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
                            style: TextStyle(
                              color: const Color.fromARGB(255, 217, 217, 217),
                            ),
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
                            style: TextStyle(
                              color: const Color.fromARGB(255, 217, 217, 217),
                            ),
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
                      ],
                    ),
                  ),
                  // InputField(icon: Icons.people, hint: "Your Email/Id"),
                  // InputField(icon: Icons.lock, hint: "Your Password"),

                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => Loginkosong()),
                  //     );
                  //   },
                  //   child: Text("Login"),
                  // ),
                  SizedBox(height: 30),
                  // LoginButton(
                  //   sosmed: "Daftar",
                  //   warnaBox: Color(0xFF062592),
                  //   loginSize: 15,
                  // ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF062592),
                      foregroundColor: Color.fromARGB(255, 217, 217, 217),
                      minimumSize: Size(double.infinity, 60),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.all(20),
                              title: Text("Konfirmasi Data"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text("Nama : ${nameController.text}"),
                                  Text("Email : ${emailController.text}"),
                                  Text("No. HP : ${nohpController.text}"),
                                  Text("Alamat: ${addressController.text}"),
                                  Text("Instansi : ${instansiController.text}"),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },

                                  child: Text("Batal"),
                                ),

                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Tugas10HalamanTerimaKasih(
                                              nama: nameController.text,
                                              namainstansi:
                                                  instansiController.text,
                                            ),
                                      ),
                                    );
                                  },
                                  child: Text("Lanjut"),
                                ),
                              ],
                            );
                          },
                        );

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => Tugas10HalamanTerimaKasih(
                        //       nama: nameController.text,
                        //       namainstansi: instansiController.text,
                        //     ),
                        //   ),
                        // );
                      }
                    },
                    child: Text("Daftar"),
                  ),

                  SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Color(0xFF999999),
                            thickness: 2,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 30,
                          ),
                          child: Text(
                            "or",
                            style: TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 15,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Divider(
                            color: Color(0xFF999999),
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SocmedButton(
                          sosmed: "Facebook",
                          warnaBox: Color.fromARGB(255, 27, 53, 77),
                          loginSize: 15,
                        ),
                      ),
                      Expanded(
                        child: SocmedButton(
                          sosmed: "Gmail",
                          warnaBox: Color.fromARGB(255, 27, 53, 77),
                          loginSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
