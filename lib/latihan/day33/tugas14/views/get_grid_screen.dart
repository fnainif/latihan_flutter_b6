import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/day33/tugas14/models/wallpaper_models.dart';
import 'package:latihan_flutter_b6/latihan/day33/tugas14/service/api_services.dart';

class ApiGrid extends StatefulWidget {
  const ApiGrid({super.key});

  @override
  State<ApiGrid> createState() => _ApiGridState();
}

class _ApiGridState extends State<ApiGrid> {
  late final ApiService apiService;
  late Future<WallpaperModels> _postsFuture;

  @override
  void initState() {
    super.initState();
    final dio = Dio();
    apiService = ApiService(dio);
    _postsFuture = apiService.getAllPosts();
  }

  void _refreshPosts() {
    setState(() {
      _postsFuture = apiService.getAllPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      body: FutureBuilder<WallpaperModels>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'Gagal memuat data:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ), // Text
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _refreshPosts,
                      child: const Text('Coba Lagi'),
                    ), // ElevatedButton
                  ],
                ), // Column
              ), // Padding
            ); // Center
          }

          final posts = snapshot.data!;

          return RefreshIndicator(
            onRefresh: () async => _refreshPosts(),
            child: GridView.builder(
              itemCount: posts.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Jumlah kolom
                crossAxisSpacing: 10, // Jarak antar kolom (horizontal)
                mainAxisSpacing: 10, // Jarak antar baris (vertical)
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                final post = posts.data[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ), // EdgeInsets.symmetric
                  // child: ListTile(
                  //   leading: CircleAvatar(
                  //     backgroundColor: Colors.blue,
                  //     child: Text(
                  //       post.id,
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 12,
                  //       ), // TextStyle
                  //     ), // Text
                  //   ), // CircleAvatar
                  //   title: Text(
                  //     post.title ?? "",
                  //     maxLines: 1,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: const TextStyle(fontWeight: FontWeight.w600),
                  //   ), // Text
                  //   subtitle: Text(
                  //     post.body ?? "",
                  //     maxLines: 2,
                  //     overflow: TextOverflow.ellipsis,
                  //   ), // Text
                  //   trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  // ),
                  child: Image.network(post.thumbs.original),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
