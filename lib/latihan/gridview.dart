import 'package:flutter/material.dart';

class GridviewDay10 extends StatelessWidget {
  const GridviewDay10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 203, 238),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 161, 85, 138),
        title: Text(
          "Pemesanan",
          style: TextStyle(
            fontFamily: "Quicksand",
            color: const Color.fromARGB(255, 255, 203, 238),
          ),
        ),
        leading: Icon(
          Icons.home,
          color: const Color.fromARGB(255, 255, 203, 238),
        ),
        actions: [
          Icon(
            Icons.shopping_bag,
            color: const Color.fromARGB(255, 255, 203, 238),
          ),
          SizedBox(width: 10),
          Icon(
            Icons.notifications,
            color: const Color.fromARGB(255, 255, 203, 238),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text(
              "Form Pemesanan",
              style: TextStyle(
                fontFamily: "Super",
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 161, 85, 138),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.purpleAccent),
                ),
                hintText: "masukan nama",
                labelText: "Nama",
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.purpleAccent),
                ),
                hintText: "masukan email",
                labelText: "Email",
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.purpleAccent),
                ),
                hintText: "masukan nomer HP",
                labelText: "No. HP",
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.purpleAccent),
                ),
                hintText: "masukan deskripsi pesanan",
                labelText: "Deskripsi",
              ),
            ),

            SizedBox(height: 40),

            Text(
              "Katalog",
              style: TextStyle(
                fontFamily: "Super",
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 161, 85, 138),
              ),
            ),

            GridView.count(
              padding: EdgeInsets.only(top: 20),
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                contentGrid(
                  "assets/images/product_belt.jpg",
                  "Ikat Pinggang",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_clips.jpg",
                  "Jepit Rambut",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_earrings.jpg",
                  "Anting",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_heels.jpg",
                  "Heels",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_purse.jpg",
                  "Tas Jinjing",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_purse2.jpg",
                  "Tas",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_sunglasses.jpg",
                  "Sunglasses",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_watch.jpg",
                  "Jam Tangan",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_belt.jpg",
                  "Ikat Pinggang",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_clips.jpg",
                  "Jepit Rambut",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_earrings.jpg",
                  "Anting",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_heels.jpg",
                  "Heels",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_purse.jpg",
                  "Tas Jinjing",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_purse2.jpg",
                  "Tas",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_sunglasses.jpg",
                  "Sunglasses",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_watch.jpg",
                  "Jam Tangan",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_belt.jpg",
                  "Ikat Pinggang",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_clips.jpg",
                  "Jepit Rambut",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_earrings.jpg",
                  "Anting",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_heels.jpg",
                  "Heels",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_purse.jpg",
                  "Tas Jinjing",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_purse2.jpg",
                  "Tas",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_sunglasses.jpg",
                  "Sunglasses",
                  Colors.yellow,
                ),
                contentGrid(
                  "assets/images/product_watch.jpg",
                  "Jam Tangan",
                  Colors.yellow,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Stack contentGrid(String imagePath, String postTitle, Color color) {
    return Stack(
      alignment: AlignmentGeometry.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  height: 146,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 5,
          child: Container(
            color: const Color.fromARGB(150, 211, 157, 204),
            padding: EdgeInsets.all(5),
            child: Text(
              postTitle,
              style: TextStyle(
                fontFamily: "Nunito",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
