import 'package:flutter/material.dart';

class ListviewDay10 extends StatelessWidget {
  const ListviewDay10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manajemen Data Pelanggan")),

      body: Expanded(
        child: ListView.builder(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {},
        ),
      ),
    );
  }

  Widget contacts(String imagePath, String namaPasien, String notelp) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(50),
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
                title: Text(namaPasien),
                subtitle: Text(notelp),
              );
            },
          ),
        ),
      ],
    );
  }
}
