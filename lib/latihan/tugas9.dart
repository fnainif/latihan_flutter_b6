import 'package:flutter/material.dart';

class Tugas9 extends StatelessWidget {
  const Tugas9({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 239, 244),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Menu",
              style: TextStyle(
                fontSize: 40,
                fontFamily: "Super",
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 138, 81, 125),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 182, 119, 161),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Menu Makanan Ringan Level 1\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 247, 239, 244),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 216, 178, 207),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(20),
                        itemCount: snackList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              snackList[index],
                              style: TextStyle(
                                color: const Color.fromARGB(255, 109, 62, 98),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 169, 119, 182),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Menu Makanan Ringan Level 2\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 247, 239, 244),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 199, 178, 216),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(20),
                        itemCount: snackMap.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(
                              snackMap[index]['icon'],
                              color: const Color.fromARGB(255, 109, 62, 98),
                            ),
                            title: Text(
                              snackMap[index]['nama'],
                              style: TextStyle(
                                color: const Color.fromARGB(255, 109, 62, 98),
                              ),
                            ),
                            subtitle: Text(
                              "Rp ${snackMap[index]['harga']}",
                              style: TextStyle(
                                color: const Color.fromARGB(150, 109, 62, 98),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 119, 141, 182),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Menu Makanan Ringan Level 3\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 247, 239, 244),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 178, 182, 216),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(20),
                        itemCount: snackModel.length,
                        itemBuilder: (context, index) {
                          final item = snackModel[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(item.pic),
                            ),
                            title: Text(
                              item.name,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 109, 62, 98),
                              ),
                            ),
                            subtitle: Text(
                              "Rp ${item.price}",
                              style: TextStyle(
                                color: const Color.fromARGB(150, 109, 62, 98),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<String> snackList = [
  'Keripik Kentang',
  'Wafer Coklat',
  'Popcorn Caramel',
  'Biskuit Keju',
  'Permen Mint',
  'Kacang Panggang',
  'Makaroni Pedas',
  'Donat Selai Strawberry',
  'Roti Sosis',
  'Pudding Matcha',
  'Es Krim Cup',
  'Kue Cubit',
  'Churros',
  'Martabak Mini',
  'Cireng Isi',
];

final List<Map<String, dynamic>> snackMap = [
  {'nama': 'Keripik Kentang', 'harga': 12000, 'icon': Icons.fastfood},
  {'nama': 'Wafer Coklat', 'harga': 8500, 'icon': Icons.cookie},
  {'nama': 'Popcorn Caramel', 'harga': 15000, 'icon': Icons.local_movies},
  {'nama': 'Biskuit Keju', 'harga': 10000, 'icon': Icons.lunch_dining},
  {'nama': 'Permen Mint', 'harga': 5000, 'icon': Icons.cake},
  {
    'nama': 'Kacang Panggang',
    'harga': 13000,
    'icon': Icons.energy_savings_leaf,
  },
  {'nama': 'Makaroni Pedas', 'harga': 11000, 'icon': Icons.ramen_dining},
  {'nama': 'Donat Selai Strawberry', 'harga': 9000, 'icon': Icons.donut_small},
  {'nama': 'Roti Sosis', 'harga': 14000, 'icon': Icons.breakfast_dining},
  {'nama': 'Pudding Matcha', 'harga': 7000, 'icon': Icons.icecream},
  {'nama': 'Es Krim Cup', 'harga': 16000, 'icon': Icons.icecream},
  {'nama': 'Kue Cubit', 'harga': 8000, 'icon': Icons.cake_outlined},
  {'nama': 'Churros', 'harga': 17000, 'icon': Icons.bakery_dining},
  {'nama': 'Martabak Mini', 'harga': 15000, 'icon': Icons.dinner_dining},
  {'nama': 'Cireng Isi', 'harga': 9500, 'icon': Icons.fastfood_outlined},
];

class MakananRingan {
  final String name;
  final int price;
  final String pic;

  MakananRingan({required this.name, required this.price, required this.pic});

  factory MakananRingan.fromJson(Map<String, dynamic> json) {
    return MakananRingan(
      name: json['name'],
      price: json['price'],
      pic: json['pic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, 'pic': pic};
  }
}

final List<MakananRingan> snackModel = [
  MakananRingan(
    name: 'Keripik Kentang',
    price: 12000,
    pic: "assets/images/product_belt.jpg",
  ),
  MakananRingan(
    name: 'Wafer Coklat',
    price: 8500,
    pic: "assets/images/product_clips.jpg",
  ),
  MakananRingan(
    name: 'Popcorn Caramel',
    price: 15000,
    pic: "assets/images/product_earrings.jpg",
  ),
  MakananRingan(
    name: 'Biskuit Keju',
    price: 10000,
    pic: "assets/images/product_heels.jpg",
  ),
  MakananRingan(
    name: 'Permen Mint',
    price: 5000,
    pic: "assets/images/product_purse.jpg",
  ),
  MakananRingan(
    name: 'Kacang Panggang',
    price: 13000,
    pic: "assets/images/product_purse2.jpg",
  ),
  MakananRingan(
    name: 'Makaroni Pedas',
    price: 11000,
    pic: "assets/images/product_sunglasses.jpg",
  ),
  MakananRingan(
    name: 'Donat Selai Strawberry',
    price: 9000,
    pic: "assets/images/product_watch.jpg",
  ),
  MakananRingan(
    name: 'Roti Sosis',
    price: 14000,
    pic: "assets/images/product_belt.jpg",
  ),
  MakananRingan(
    name: 'Pudding Matcha',
    price: 7000,
    pic: "assets/images/product_clips.jpg",
  ),
  MakananRingan(
    name: 'Es Krim Cup',
    price: 16000,
    pic: "assets/images/product_earrings.jpg",
  ),
  MakananRingan(
    name: 'Kue Cubit',
    price: 8000,
    pic: "assets/images/product_heels.jpg",
  ),
  MakananRingan(
    name: 'Churros',
    price: 17000,
    pic: "assets/images/product_purse.jpg",
  ),
  MakananRingan(
    name: 'Martabak Mini',
    price: 15000,
    pic: "assets/images/product_purse2.jpg",
  ),
  MakananRingan(
    name: 'Cireng Isi',
    price: 9500,
    pic: "assets/images/product_belt.jpg",
  ),
];
