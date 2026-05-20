import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/reusable_login.dart';

class LoginDay13 extends StatefulWidget {
  const LoginDay13({super.key});

  @override
  State<LoginDay13> createState() => _LoginDay13State();
}

class _LoginDay13State extends State<LoginDay13> {
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
                  InputField(icon: Icons.people, hint: "Your Email/Id"),
                  InputField(icon: Icons.lock, hint: "Your Password"),

                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Forget Password ?",
                      style: TextStyle(color: Color(0xFF999999)),
                    ),
                  ),

                  SizedBox(height: 20),

                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => Loginkosong()),
                  //     );
                  //   },
                  //   child: Text("Login"),
                  // ),
                  LoginButton(
                    sosmed: "Login",
                    warnaBox: Color(0xFF062592),
                    loginSize: 15,
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
