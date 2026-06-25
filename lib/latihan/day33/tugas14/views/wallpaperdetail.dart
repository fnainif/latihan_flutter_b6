import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latihan_flutter_b6/latihan/day33/tugas14/models/wallpaper_models.dart';
import 'package:path_provider/path_provider.dart';

class WallpaperDetailScreen extends StatefulWidget {
  final Datum post;
  const WallpaperDetailScreen({super.key, required this.post});

  @override
  State<WallpaperDetailScreen> createState() => _WallpaperDetailScreenState();
}

class _WallpaperDetailScreenState extends State<WallpaperDetailScreen> {
  String _selectedSize = "large"; // Choices: small, large, original
  bool _isDownloading = false;
  bool showHeart = false;
  double _downloadProgress = 0.0;

  String get _downloadUrl {
    switch (_selectedSize) {
      case "small":
        return widget.post.thumbs.small;
      case "large":
        return widget.post.thumbs.large;
      case "original":
      default:
        return widget.post.path;
    }
  }

  Color _parseHexColor(String hexStr) {
    try {
      String cleanHex = hexStr.replaceAll("#", "");
      if (cleanHex.length == 6) {
        cleanHex = "FF$cleanHex";
      }
      return Color(int.parse("0x$cleanHex"));
    } catch (e) {
      return Colors.grey;
    }
  }

  Future<String> _getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isWindows) {
        final userProfile = Platform.environment['USERPROFILE'];
        if (userProfile != null) {
          final downloadDir = Directory('$userProfile\\Downloads');
          if (await downloadDir.exists()) {
            return downloadDir.path;
          }
        }
        directory = await getDownloadsDirectory();
      } else if (Platform.isAndroid) {
        final downloadDir = Directory('/storage/emulated/0/Download');
        if (await downloadDir.exists()) {
          return downloadDir.path;
        }
        directory = await getExternalStorageDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }
    } catch (e) {
      // Ignore and fallback
    }
    directory ??= await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _downloadImage() async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    try {
      final dio = Dio();
      final baseDir = await _getDownloadPath();
      final url = _downloadUrl;
      final extension = url.split('.').last.split('?').first;
      final filename = "wallpaper_${widget.post.id}_$_selectedSize.$extension";
      final savePath = "$baseDir${Platform.pathSeparator}$filename";

      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _downloadProgress = received / total;
            });
          }
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gambar berhasil diunduh ke:\n$savePath"),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: "Buka Folder",
              textColor: Colors.white,
              onPressed: () {
                if (Platform.isWindows) {
                  Process.run('explorer.exe', ['/select,', savePath]);
                }
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal mengunduh gambar: $e"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
          _downloadProgress = 0.0;
        });
      }
    }
  }

  void _showFullScreenImage() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          alignment: Alignment.center,
          children: [
            InteractiveViewer(
              maxScale: 4.0,
              minScale: 0.5,
              child: Image.network(
                widget.post.path,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        widget.post.thumbs.large,
                        fit: BoxFit.contain,
                      ),
                      const CircularProgressIndicator(color: Color(0xFF9999EC)),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF9999EC), Color(0xFF2E2A4F), Color(0xFF000000)],
          ),
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.55,
              pinned: true,
              backgroundColor: const Color(0xFF0C0C14),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    GestureDetector(
                      onTap: _showFullScreenImage,
                      child: Hero(
                        tag: post.id,
                        child: Image.network(
                          post.path,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            // Show large thumb first while full resolution path is loading
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  post.thumbs.large,
                                  fit: BoxFit.cover,
                                ),
                                const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF9999EC),
                                  ),
                                ),
                              ],
                            );
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: const Color(0xFF1E1E38),
                                child: const Icon(
                                  Icons.broken_image,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                              ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 36,
                      right: 16,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                showHeart = !showHeart;
                              });
                            },
                            icon: showHeart
                                ? Icon(Icons.favorite, color: Colors.redAccent)
                                : Icon(
                                    Icons.favorite_outline,
                                    color: Colors.white70,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    // Click to Zoom Badge
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.zoom_in, size: 16, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              "Tap to Zoom",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black45,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),

            // Wallpaper Info and Download Actions
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ID: ${post.id}",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF9999EC),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF9999EC),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              post.category.name.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E2A4F),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        "Detail Wallpaper",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF16162A),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            _buildDetailItem(
                              icon: Icons.aspect_ratio,
                              label: "Resolution",
                              value: post.resolution,
                            ),
                            const Divider(color: Colors.white10),
                            _buildDetailItem(
                              icon: Icons.visibility_outlined,
                              label: "Views",
                              value: "${post.views}",
                            ),
                            const Divider(color: Colors.white10),
                            _buildDetailItem(
                              icon: Icons.favorite_outline,
                              label: "Favorite",
                              value: "${post.favorites}",
                            ),
                            const Divider(color: Colors.white10),
                            _buildDetailItem(
                              icon: Icons.security_outlined,
                              label: "Purity",
                              value: post.purity.name.toUpperCase(),
                            ),
                            const Divider(color: Colors.white10),
                            _buildDetailItem(
                              icon: Icons.category_outlined,
                              label: "Category",
                              value: post.category.name.toUpperCase(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Color palette section
                      if (post.colors.isNotEmpty) ...[
                        const Text(
                          "Warna Dominan (Ketuk untuk menyalin)",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 12,
                          runSpacing: 10,
                          children: post.colors.map((hex) {
                            final parsedColor = _parseHexColor(hex);
                            return Tooltip(
                              message: "Salin $hex",
                              child: GestureDetector(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(text: hex));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Kode warna $hex berhasil disalin!",
                                        style: TextStyle(
                                          color:
                                              parsedColor.computeLuminance() >
                                                  0.5
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                      backgroundColor:
                                          parsedColor.computeLuminance() > 0.5
                                          ? Color.fromARGB(255, 169, 169, 246)
                                          : Color(0xFF5852a0),
                                      behavior: SnackBarBehavior.floating,
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: parsedColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white70,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Download section
                      const Text(
                        "Unduh Gambar",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF16162A),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Pilih Ukuran:",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildSizeChip("small", "Small"),
                                _buildSizeChip("large", "Large"),
                                _buildSizeChip("original", "Original"),
                              ],
                            ),
                            const SizedBox(height: 20),

                            if (_isDownloading) ...[
                              LinearProgressIndicator(
                                value: _downloadProgress,
                                backgroundColor: Colors.white10,
                                valueColor: const AlwaysStoppedAnimation(
                                  Color(0xFF9999EC),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Mengunduh: ${(_downloadProgress * 100).toStringAsFixed(0)}%",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],

                            ElevatedButton.icon(
                              onPressed: _isDownloading ? null : _downloadImage,
                              icon: _isDownloading
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Icon(Icons.download),
                              label: Text(
                                _isDownloading
                                    ? "Mengunduh..."
                                    : "Mulai Unduhan",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF9999EC),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeChip(String sizeKey, String label) {
    final isSelected = _selectedSize == sizeKey;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedSize = sizeKey;
          });
        }
      },
      selectedColor: const Color(0xFF9999EC),
      backgroundColor: Colors.white10,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : const Color(0xFF9999EC),
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFFC7C7FC)),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(color: Colors.white60, fontSize: 14),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
