import 'package:flutter/material.dart';

class Tugas5Day12 extends StatefulWidget {
  const Tugas5Day12({super.key});

  @override
  State<Tugas5Day12> createState() => _Tugas5Day12State();
}

class _Tugas5Day12State extends State<Tugas5Day12> {
  int nilaiCounter = 0;
  bool like = false;
  bool showElevated = false;
  bool showHeart = false;
  bool showParagraf = false;
  bool showInkwell = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 203, 238),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nilaiCounter--;
          print("Dikurangi");
        },
        child: Icon(Icons.remove),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 161, 85, 138),
        title: Text(
          "Detail Buku",
          style: TextStyle(
            fontFamily: "Quicksand",
            color: const Color.fromARGB(255, 255, 203, 238),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                "Perempuan Di Titik Nol",
                style: TextStyle(
                  fontFamily: "Super",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 161, 85, 138),
                ),
              ),

              Text(
                "Nawal El Saadawi",
                style: TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 161, 85, 138),
                ),
              ),
              SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("assets/images/novel.jpg", height: 200),
              ),
              SizedBox(height: 10),

              IconButton(
                onPressed: () {
                  setState(() {
                    showHeart = !showHeart;
                    like = !like;
                  });
                },
                icon: Icon(
                  Icons.favorite,
                  color: like ? Colors.red : Colors.black,
                ),
              ),
              if (showHeart)
                Text(
                  "Ditambahkan ke favorit",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    color: const Color.fromARGB(255, 161, 85, 138),
                  ),
                ),

              Container(
                padding: EdgeInsets.all(40),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 161, 85, 138),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showElevated = !showElevated;
                        });
                      },
                      child: Text(
                        "Blurb",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 161, 85, 138),
                          fontFamily: "Nunito",
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    if (showElevated)
                      Text(
                        "Dari balik sel penjara, Firdaus -- yang divonis gantung karena telah membunuh seorang germo -- mengisahkan liku-liku kehidupannya. Dari sejak masa kecilnya di desa, hingga ia menjadi pelacur kelas atas di Kota Kairo. Ia menyambut gembira hukuman gantung itu. Bahkan dengan tegas ia menolak grasi kepada presiden yang diusulkan oleh dokter penjara. Menurut Firdaus, vonis itu justru merupakan satu-satunya jalan menuju kebebasan sejati. Ironis.",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 230, 209, 223),
                          fontFamily: "Nunito",
                        ),
                      ),

                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              splashColor: const Color.fromARGB(
                                255,
                                255,
                                255,
                                255,
                              ),
                              onTap: () {
                                setState(() {
                                  showInkwell = !showInkwell;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    218,
                                    136,
                                    193,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 50,
                                width: 100,
                                child: Center(
                                  child: Text(
                                    "Rating",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontFamily: "Nunito",
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10),

                            if (showInkwell)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      "4.24",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Nunito",
                                        color: const Color.fromARGB(
                                          255,
                                          240,
                                          226,
                                          236,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "/ 5",
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                              255,
                                              245,
                                              195,
                                              230,
                                            ),
                                            fontFamily: "Nunito",
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: const Color.fromARGB(
                                            255,
                                            245,
                                            195,
                                            230,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),

                        Flexible(
                          child: Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    showParagraf = !showParagraf;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      218,
                                      136,
                                      193,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 50,
                                  width: 100,
                                  child: Center(
                                    child: Text(
                                      "Tags",
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          255,
                                          255,
                                          255,
                                          255,
                                        ),
                                        fontFamily: "Nunito",
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              if (showParagraf)
                                Container(
                                  padding: EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    "Fiction, Feminism, Egypt, Classics, Africa, Middle East, Womens, Literary Fiction",
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        245,
                                        195,
                                        230,
                                      ),
                                      fontFamily: "Nunito",
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 40),

                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  nilaiCounter++;
                                  setState(() {
                                    print("Ditekan Sekali");
                                  });
                                },

                                onDoubleTap: () {
                                  nilaiCounter += 2;
                                  setState(() {
                                    print("ditekan dua kali");
                                  });
                                },

                                onLongPress: () {
                                  nilaiCounter += 3;
                                  setState(() {
                                    print("Tahan Lama");
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      "assets/images/book2.png",
                                      height: 100,
                                    ),
                                  ),
                                ),
                              ),

                              Text(
                                "Jumlah buku bulan ini : $nilaiCounter",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Nunito",
                                  color: const Color.fromARGB(
                                    255,
                                    161,
                                    85,
                                    138,
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
