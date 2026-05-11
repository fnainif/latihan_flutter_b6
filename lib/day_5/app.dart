import 'package:flutter/material.dart';

class AppDemo extends StatelessWidget {
  const AppDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 225, 247),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 180, 111, 171),
        title: Text(
          "Detail Toko",
          style: TextStyle(
            fontFamily: "Quicksand",
            fontSize: 30,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),

      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: const Center(
              child: Column(
                children: [
                  Text(
                    "Harumony Mystic Emporium",
                    style: TextStyle(fontFamily: "Tangerine", fontSize: 50),
                  ),
                ],
              ),
            ),
          ),

          Container(
            height: 50,
            margin: const EdgeInsets.all(20),
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 0.5),
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 163, 74, 126),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                  blurStyle: BlurStyle.inner,
                ),
              ],
            ),

            child: Row(
              children: [
                Icon(Icons.email),
                SizedBox(width: 20),
                Text(
                  "harumony.id",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 20,
                    right: 10,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Icons.call),
                      SizedBox(width: 10),
                      Text(
                        "083841111864",
                        style: TextStyle(fontFamily: "Nunito"),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(flex: 1),
              Expanded(
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 10,
                    right: 20,
                  ),
                  padding: EdgeInsets.all(10),

                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 10),
                      Text(
                        "Jakarta, Indonesia",
                        style: TextStyle(fontFamily: "Nunito"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 80,
                  margin: const EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 0.5),
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 214, 160, 205),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                        blurStyle: BlurStyle.inner,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "300+",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "books sold per month",
                        style: TextStyle(fontFamily: "Nunito", fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  height: 80,
                  margin: const EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 0.5),
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 214, 160, 205),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                        blurStyle: BlurStyle.inner,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "4.8 / 5 🌟",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "rating by user",
                        style: TextStyle(fontFamily: "Nunito", fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 50),

          Container(
            margin: const EdgeInsets.all(20),
            child: Text(
              "Harumony Mystic Emporium adalah toko buku bernuansa magis yang menghadirkan koleksi novel fantasi, buku misteri, mitologi, spiritualitas, hingga literatur klasik dalam suasana hangat dan estetik. Dengan sentuhan tema celestial dan enchanted, toko ini dirancang sebagai tempat nyaman bagi para pecinta buku untuk menjelajahi dunia imajinasi, pengetahuan, dan kisah penuh keajaiban. Selain buku, Harumony Mystic Emporium juga menawarkan berbagai aksesori dan dekorasi bertema mystic yang menambah pengalaman membaca terasa lebih unik dan memikat.",
              textAlign: TextAlign.justify,
            ),
          ),

          SizedBox(height: 20),

          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.5),
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 214, 160, 205),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                    blurStyle: BlurStyle.inner,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/images03.png"),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
