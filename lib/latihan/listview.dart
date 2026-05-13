import 'package:flutter/material.dart';

class ListviewDay10 extends StatelessWidget {
  const ListviewDay10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 203, 238),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 161, 85, 138),
        title: Text(
          "Manajemen Data Pelanggan",
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
          Icon(Icons.settings, color: const Color.fromARGB(255, 255, 203, 238)),
          SizedBox(width: 20),
        ],
      ),

      body: ListView(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        physics: BouncingScrollPhysics(),
        children: [
          Center(
            child: Text(
              "Pendaftaran",
              style: TextStyle(
                fontFamily: "Super",
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 161, 85, 138),
              ),
            ),
          ),

          SizedBox(height: 20),

          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.purpleAccent),
              ),
              hintText: "masukan nama pembeli",
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
              hintText: "masukan nomer hp",
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
              hintText: "masukan alamat pengiriman",
              labelText: "Alamat",
            ),
          ),

          SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: const Color.fromARGB(255, 161, 85, 138),
              ),
            ),
            child: Text(
              "Submit",
              style: TextStyle(
                color: const Color.fromARGB(255, 161, 85, 138),
                fontFamily: "Super",
                fontSize: 20,
              ),
            ),
          ),

          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 161, 85, 138),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Data Pelanggan",
                    style: TextStyle(
                      fontFamily: "Super",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 203, 238),
                    ),
                  ),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: contacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 255, 203, 238),
                              Color.fromARGB(255, 204, 203, 255),
                              Color.fromARGB(255, 203, 255, 207),
                            ],
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            contacts[index]["pp"]!,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        contacts[index]["nama"]!,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 203, 238),
                          fontFamily: "Nunito",
                        ),
                      ),
                      subtitle: Text(
                        contacts[index]["alamat"]!,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 228, 141, 199),
                          fontFamily: "Nunito",
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: const Color.fromARGB(255, 228, 141, 199),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),

      // ListView.builder(
      //   clipBehavior: Clip.none,
      //   scrollDirection: Axis.horizontal,
      //   physics: BouncingScrollPhysics(),
      //   itemCount: 2,
      //   itemBuilder: (BuildContext context, int index) {
      //     return contacts("assets/images/image01.jpg", "Cici", "091234");
      //   },
      // ),
    );
  }

  //   Widget contacts(String imagePath, String namaPasien, String notelp) {
  //     return Row(
  //       children: [
  //         Expanded(
  //           flex: 8,
  //           child: ListView.builder(
  //             physics: BouncingScrollPhysics(),
  //             itemCount: 10,
  //             itemBuilder: (BuildContext context, int index) {
  //               return ListTile(
  //                 leading: ClipRRect(
  //                   borderRadius: BorderRadiusGeometry.circular(50),
  //                   child: Image.asset(imagePath, fit: BoxFit.cover),
  //                 ),
  //                 title: Text(namaPasien),
  //                 subtitle: Text(notelp),
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     );
  //   }
}

final List<Map<String, String>> contacts = [
  {
    "nama": "Ananda",
    "alamat": "Jakarta, Indonesia",
    "pp": "assets/images/product_watch.jpg",
  },
  {
    "nama": "Bella",
    "alamat": "Bekasi, Indonesia",
    "pp": "assets/images/product_purse.jpg",
  },
  {
    "nama": "Chyntia",
    "alamat": "Ciamis, Indonesia",
    "pp": "assets/images/product_purse2.jpg",
  },
  {
    "nama": "Dennis",
    "alamat": "Depok, Indonesia",
    "pp": "assets/images/product_heels.jpg",
  },
  {
    "nama": "Erlangga",
    "alamat": "Tangerang, Indonesia",
    "pp": "assets/images/product_clips.jpg",
  },
  {
    "nama": "Farah",
    "alamat": "Bogor, Indonesia",
    "pp": "assets/images/product_earrings.jpg",
  },
  {
    "nama": "Gita",
    "alamat": "Surabaya, Indonesia",
    "pp": "assets/images/product_watch.jpg",
  },
  {
    "nama": "Herry",
    "alamat": "Malang, Indonesia",
    "pp": "assets/images/product_belt.jpg",
  },
  {
    "nama": "Indah",
    "alamat": "Bandung, Indonesia",
    "pp": "assets/images/product_sunglasses.jpg",
  },
  {
    "nama": "Joshua",
    "alamat": "Banyuwangi, Indonesia",
    "pp": "assets/images/product_heels.jpg",
  },
  {
    "nama": "Kala",
    "alamat": "Bantul, Indonesia",
    "pp": "assets/images/product_purse.jpg",
  },
  {
    "nama": "Lima",
    "alamat": "Lampung, Indonesia",
    "pp": "assets/images/product_purse2.jpg",
  },
  {
    "nama": "Manda",
    "alamat": "Batu, Indonesia",
    "pp": "assets/images/product_earrings.jpg",
  },
  {
    "nama": "Nadia",
    "alamat": "Kutoarjo, Indonesia",
    "pp": "assets/images/product_belt.jpg",
  },
  {
    "nama": "Omar",
    "alamat": "Serang, Indonesia",
    "pp": "assets/images/product_clips.jpg",
  },
];
