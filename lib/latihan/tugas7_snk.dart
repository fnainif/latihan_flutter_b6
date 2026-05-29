import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/day15mainpage.dart';
import 'package:latihan_flutter_b6/latihan/day19/database/preference_handler.dart';
import 'package:latihan_flutter_b6/latihan/tugas10_pendaftaran.dart';
import 'package:latihan_flutter_b6/latihan/tugas7_drawer.dart';

class Tugas7snk extends StatefulWidget {
  const Tugas7snk({super.key, required this.isSwitch});
  final bool isSwitch;

  @override
  State<Tugas7snk> createState() => _Tugas7snkState();
}

class _Tugas7snkState extends State<Tugas7snk> {
  late bool isSwitch;
  bool isCheck = false;
  @override
  void initState() {
    super.initState();

    isSwitch = widget.isSwitch;
  }

  void _prosesLogout() async {
    await PreferenceHandler.logOut();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil logout"),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Tugas10Pendaftaran()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Term of Service"),
        actions: [
          IconButton(onPressed: _prosesLogout, icon: Icon(Icons.logout)),
        ],
      ),
      drawer: Tugas7Drawer(
        isSwitch: isSwitch,

        onChanged: (value) {
          setState(() {
            isSwitch = value;
          });
        },
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: isSwitch
                ? Expanded(
                    child: Container(
                      color: const Color.fromARGB(255, 83, 43, 63),
                    ),
                  )
                : Expanded(
                    child: Container(
                      color: const Color.fromARGB(255, 255, 161, 233),
                    ),
                  ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                Text(
                  "Term and Condition",
                  style: TextStyle(
                    color: isSwitch
                        ? const Color.fromARGB(255, 248, 231, 241)
                        : const Color.fromARGB(255, 53, 6, 35),
                    fontSize: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain...",
                    style: TextStyle(
                      color: isSwitch
                          ? const Color.fromARGB(255, 248, 231, 241)
                          : const Color.fromARGB(255, 53, 6, 35),
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isSwitch
                        ? const Color.fromARGB(255, 53, 6, 35)
                        : const Color.fromARGB(255, 248, 231, 241),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas vel tellus enim. Quisque mattis euismod erat, vitae pretium elit laoreet non. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In et turpis id nisl interdum pulvinar. Integer consectetur purus sit amet dui condimentum venenatis. Proin tincidunt scelerisque orci a egestas. Phasellus viverra massa et lectus cursus vestibulum. Sed pretium in nunc ac tincidunt.\n\nMauris dignissim orci tortor, vel eleifend tortor hendrerit sit amet. Mauris ultrices lorem vitae ante eleifend, et imperdiet nisl fringilla. Mauris congue nunc quis ornare hendrerit. Aliquam ornare imperdiet nulla et sollicitudin. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Aliquam pretium dolor eu nisl feugiat, at mattis lacus lobortis. Phasellus vestibulum sollicitudin lectus, id pretium dolor tempor sit amet. Aenean at massa eu urna consectetur tempor at in augue.\n\nPraesent tincidunt libero lorem, id efficitur tortor efficitur eget. Proin sed purus viverra, maximus nibh sit amet, semper quam. Vivamus eget fermentum ex. Aenean dictum enim sed nunc sodales volutpat. Aenean libero metus, porta ut ligula eget, feugiat fringilla orci. Sed elementum tortor dolor, id pharetra sem scelerisque sit amet. Donec consectetur tristique tortor, id hendrerit ipsum lacinia eu. ",
                        style: TextStyle(
                          color: isSwitch
                              ? const Color.fromARGB(255, 243, 232, 240)
                              : const Color.fromARGB(255, 196, 110, 176),
                        ),
                      ),
                      Divider(),
                      Row(
                        children: [
                          Checkbox(
                            value: isCheck,
                            onChanged: (bool? value) {
                              setState(() {});
                              isCheck = value ?? false;
                            },
                          ),
                          Text(
                            isCheck
                                ? "Pendaftaran diperbolehkan"
                                : "Pendaftaran belum tersedia",
                            style: TextStyle(
                              color: isSwitch
                                  ? const Color.fromARGB(255, 243, 232, 240)
                                  : const Color.fromARGB(255, 196, 110, 176),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (isCheck != false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainPageDay15(
                                    initialIndex: 1,
                                    isSwitch: isSwitch,
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Klik setuju")),
                              );
                            }
                          },
                          child: Text(
                            "Daftar",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 196, 110, 176),
                            ),
                          ),
                        ),
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
