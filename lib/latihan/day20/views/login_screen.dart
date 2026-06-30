import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/day20/database/db_helper.dart';
import 'package:latihan_flutter_b6/latihan/day20/views/homescreen.dart';
import 'package:latihan_flutter_b6/latihan/day20/views/register_screen.dart';
import 'package:latihan_flutter_b6/latihan/kumpulan/reusable_login.dart';

class LoginDay20 extends StatefulWidget {
  const LoginDay20({super.key});

  @override
  State<LoginDay20> createState() => _LoginDay20State();
}

class _LoginDay20State extends State<LoginDay20> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() async {
    final email = emailController.text.trim();
    final pass = passwordController.text;

    if (email.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Isi semua field!')));
      return;
    }

    final pengguna = await DBHelper().loginUser(email, pass);

    if (pengguna != null) {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomescreenDay20()),
        (Route<dynamic> route) => false,
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login gagal! email atau Password salah.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011B33),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 355,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 217, 217, 217),
                image: DecorationImage(
                  image: AssetImage("assets/images/product_heels.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 40,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
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

            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 16,
                    ),
                    child: TextField(
                      controller: emailController,
                      style: const TextStyle(color: Color(0xFF999999)),
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Icon(Icons.people, color: Color(0xFF999999)),
                        ),
                        hintText: "Your email",
                        hintStyle: TextStyle(
                          color: Color.fromARGB(150, 217, 217, 217),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(50, 156, 155, 155),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 16,
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true, // Menyembunyikan ketikan password
                      style: const TextStyle(color: Color(0xFF999999)),
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Icon(Icons.lock, color: Color(0xFF999999)),
                        ),
                        hintText: "Your password",
                        hintStyle: TextStyle(
                          color: Color.fromARGB(150, 217, 217, 217),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(50, 156, 155, 155),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterDay20(),
                          ),
                        );
                      },
                      child: const Text(
                        "Do not have an account?",
                        style: TextStyle(color: Color(0xFF999999)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: () {
                      login();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF062592),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 217, 217, 217),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Color(0xFF999999),
                            thickness: 2,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
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
                        const Expanded(
                          child: Divider(
                            color: Color(0xFF999999),
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Row(
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
