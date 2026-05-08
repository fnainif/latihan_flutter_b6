import 'package:flutter/material.dart';

class ProfileDay5 extends StatelessWidget {
  const ProfileDay5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 213, 248),
      appBar: AppBar(
        title: Text(
          "Profil Saya",
          style: TextStyle(
            color: const Color.fromARGB(255, 247, 229, 241),
            fontFamily: "Jacquard12",
            fontSize: 40,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 180, 116, 185),
        centerTitle: true,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "Farida Nur Aini",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: "Super",
                color: const Color.fromARGB(255, 143, 71, 121),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: const Color.fromARGB(255, 145, 67, 121),
              ),
              Text("Jakarta, Indonesia", style: TextStyle(fontSize: 20)),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Seorang mahasiswa yang sedang belajar flutter di PPKD Jakarta Pusat",
              style: TextStyle(
                fontSize: 15,
                color: const Color.fromARGB(255, 196, 150, 204),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(10),
            width: 350,
            height: 150,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 14, 7, 53),
                  blurRadius: 10,
                  offset: Offset(5, 5),
                  blurStyle: BlurStyle.inner,
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 129, 81, 127),
            ), // oxDecoration
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/image01.jpg",
                    width: 90,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(bottom: 10, left: 10),
                  width: 230,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.all(5)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.email,
                                color: const Color.fromARGB(255, 129, 81, 127),
                              ),
                              Text(
                                "Contacts",
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    129,
                                    81,
                                    127,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.all(5)),
                              Icon(
                                Icons.brush,
                                color: const Color.fromARGB(255, 129, 81, 127),
                              ),
                              Text(
                                "Gallery",
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    129,
                                    81,
                                    127,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.all(5)),
                              Icon(
                                Icons.attach_money,
                                color: const Color.fromARGB(255, 129, 81, 127),
                              ),
                              Text(
                                "Commissions",
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    129,
                                    81,
                                    127,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.all(5)),
                              Icon(
                                Icons.home,
                                color: const Color.fromARGB(255, 129, 81, 127),
                              ),
                              Text(
                                "Home",
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    129,
                                    81,
                                    127,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
