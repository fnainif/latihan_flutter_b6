import 'package:flutter/material.dart';

class ScaffoldDay5 extends StatelessWidget {
  const ScaffoldDay5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 154, 240),
      appBar: AppBar(
        actions: [Text("Keluar")],
        centerTitle: true,
        title: Text("Test scaffold"),
      ), // appBar
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(children: [Text("Body content"), Text("Content 2")]),
          Column(children: [Text("Body content"), Text("Content 2")]),
          Column(children: [Text("Body content"), Text("Content 2")]),
          Column(children: [Text("Body content"), Text("Content 2")]),
        ],
      ), // body
    );
  }
}
