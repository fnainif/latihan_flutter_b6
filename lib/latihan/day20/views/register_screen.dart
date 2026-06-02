import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/day20/database/db_helper.dart';
import 'package:latihan_flutter_b6/latihan/day20/models/user_model_sql.dart';
import 'package:latihan_flutter_b6/latihan/day20/views/homescreen.dart';
import 'package:latihan_flutter_b6/latihan/day20/views/login_screen.dart';
import 'package:latihan_flutter_b6/latihan/reusable_login.dart';

class RegisterDay20 extends StatefulWidget {
  const RegisterDay20({super.key});

  @override
  State<RegisterDay20> createState() => _RegisterDay20State();
}

class _RegisterDay20State extends State<RegisterDay20> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nohpController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                            controller: passwordController,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 217, 217, 217),
                            ),
                            decoration: InputDecoration(
                              hintText: "Masukan Password",
                              labelText: "Password",
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return "Password tidak boleh kosong";
                              if (value.length < 6)
                                return "Password terlalu singkat";
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

                        SizedBox(height: 20),

                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginDay20(),
                                ),
                              );
                            },
                            child: Text(
                              "Already have an account?",
                              style: TextStyle(color: Color(0xFF999999)),
                            ),
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
                                  onPressed: () async {
                                    // 1. Ambil teks dari controller yang ada di halaman register Anda
                                    final nama = nameController.text.trim();
                                    final email = emailController.text.trim();
                                    final pass = passwordController.text;
                                    final noHp = nohpController.text.trim();
                                    final alamat = addressController.text
                                        .trim();
                                    final instansi = instansiController.text
                                        .trim();

                                    // 2. Bungkus ke dalam model UserModelSql
                                    final userBaru = UserModelSql(
                                      nama: nama,
                                      email: email,
                                      password: pass,
                                      noHp: noHp,
                                      alamat: alamat,
                                      instansi: instansi,
                                    );

                                    // 3. Simpan langsung ke database di sini!
                                    bool success = await DBHelper()
                                        .registerUser(userBaru);

                                    if (success) {
                                      // Tutup pop-up konfirmasi
                                      Navigator.pop(context);

                                      // Pindah ke halaman list (HomescreenDay20) setelah sukses menyimpan
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomescreenDay20(),
                                        ),
                                      );

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Registrasi Berhasil & Tersimpan!',
                                          ),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Registrasi Gagal! Email sudah terdaftar.',
                                          ),
                                        ),
                                      );
                                    }
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
