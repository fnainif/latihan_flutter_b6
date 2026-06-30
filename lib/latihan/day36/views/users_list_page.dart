import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/day36/models/batch_response.dart';
import 'package:latihan_flutter_b6/latihan/day36/models/training_response.dart';
import 'package:latihan_flutter_b6/latihan/day36/services/auth_service.dart';
import 'package:latihan_flutter_b6/latihan/day36/services/dio_client.dart';
import 'package:retrofit/retrofit.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  late final AuthService _authService;
  List<dynamic> _rawUsersList = [];
  List<dynamic> _filteredUsersList = [];
  Map<int, String> _trainingMap = {};
  Map<int, String> _batchMap = {};
  bool _isLoading = true;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authService = AuthService(createDioClient());
    _loadUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    setState(() => _isLoading = true);
    try {
      final results = await Future.wait([
        _authService.getDataUser(),
        _authService.getTrainings(),
        _authService.getBatches(),
      ]);

      final userResponse = results[0] as HttpResponse<dynamic>;
      final trainingResponse = results[1] as TrainingsResponse;
      final batchResponse = results[2] as BatchesResponse;

      // Pemetaan data pelatihan ke map lookup
      final trainMap = <int, String>{};
      for (final t in (trainingResponse.data ?? [])) {
        if (t.id != null && t.title != null) {
          trainMap[t.id!] = t.title!;
        }
      }

      // Pemetaan data angkatan ke map lookup
      final bMap = <int, String>{};
      for (final b in (batchResponse.data ?? [])) {
        if (b.id != null && b.batchKe != null) {
          bMap[b.id!] = 'Angkatan ${b.batchKe}';
        }
      }

      final responseData = userResponse.data;
      if (responseData != null && responseData['data'] is List) {
        if (mounted) {
          setState(() {
            _rawUsersList = responseData['data'] as List<dynamic>;
            _filteredUsersList = List.from(_rawUsersList);
            _trainingMap = trainMap;
            _batchMap = bMap;
            _isLoading = false;
          });
        }
      } else {
        throw Exception('Format data response tidak valid');
      }
    } on DioException catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal memuat data: ${e.response?.data['message'] ?? e.message}',
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memuat data: $e'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  void _filterUsers(String query) {
    setState(() {
      _filteredUsersList = _rawUsersList.where((userMap) {
        final name = (userMap['name'] ?? '').toString().toLowerCase();
        final email = (userMap['email'] ?? '').toString().toLowerCase();
        final lowerQuery = query.toLowerCase();
        return name.contains(lowerQuery) || email.contains(lowerQuery);
      }).toList();
    });
  }

  String? _getFormattedPhotoUrl(String? rawUrl) {
    if (rawUrl == null || rawUrl.trim().isEmpty) return null;
    String url = rawUrl;
    if (!url.startsWith('http')) {
      if (url.startsWith('/')) {
        url = 'https://appabsensi.mobileprojp.com$url';
      } else {
        url = 'https://appabsensi.mobileprojp.com/$url';
      }
    } else {
      url = url.replaceAll(
        'http://127.0.0.1:8000',
        'https://appabsensi.mobileprojp.com',
      );
      url = url.replaceAll(
        'http://localhost:8000',
        'https://appabsensi.mobileprojp.com',
      );
      url = url.replaceAll(
        'http://localhost',
        'https://appabsensi.mobileprojp.com',
      );
    }
    return url;
  }

  Widget _buildUserCard(Map<String, dynamic> userMap) {
    final name = userMap['name']?.toString() ?? 'Tanpa Nama';
    final email = userMap['email']?.toString() ?? '-';

    // Membaca 'role' langsung dari raw JSON map (jika ada), default 'Peserta'
    final role = userMap['role']?.toString() ?? 'Peserta';

    final trainingIdVal = userMap['training_id'];
    final batchIdVal = userMap['batch_id'];
    final profilePhoto = userMap['profile_photo']?.toString();

    int? tId;
    if (trainingIdVal is int) {
      tId = trainingIdVal;
    } else if (trainingIdVal is String) {
      tId = int.tryParse(trainingIdVal);
    }

    int? bId;
    if (batchIdVal is int) {
      bId = batchIdVal;
    } else if (batchIdVal is String) {
      bId = int.tryParse(batchIdVal);
    }

    final trainingName = tId != null
        ? (_trainingMap[tId] ?? 'Pelatihan #$tId')
        : 'Tanpa Pelatihan';
    final batchName = bId != null
        ? (_batchMap[bId] ?? 'Angkatan #$bId')
        : 'Tanpa Angkatan';

    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    final formattedPhotoUrl = _getFormattedPhotoUrl(profilePhoto);

    // Badge color berdasarkan role
    final isAdmin = role.toLowerCase() == 'admin';
    final badgeColor = isAdmin ? Colors.amber : const Color(0xFFC2185B);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.55),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar (Image or Initials)
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: isAdmin
                      ? [Colors.amber, Colors.orangeAccent]
                      : [const Color(0xFFFFC9E7), const Color(0xFFd6a7df)],
                ),
                image: formattedPhotoUrl != null
                    ? DecorationImage(
                        image: NetworkImage(formattedPhotoUrl),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {
                          // Fail-safe jika gambar gagal diload
                        },
                      )
                    : null,
              ),
              child: formattedPhotoUrl == null
                  ? Center(
                      child: Text(
                        initial,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isAdmin
                              ? Colors.white
                              : const Color(0xFFC2185B),
                        ),
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: Color(0xFFC2185B),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Role Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: badgeColor.withOpacity(0.5)),
                      ),
                      child: Text(
                        role.toUpperCase(),
                        style: TextStyle(
                          color: badgeColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 16),
                // Chips for ID (Wrap to avoid text overflow)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildChip(label: trainingName, icon: Icons.school),
                    _buildChip(label: batchName, icon: Icons.groups),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip({required String label, required IconData icon}) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 160, // Membatasi lebar maksimal agar tidak meluap dari kartu
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFFC2185B)),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                color: Color(0xFFC2185B),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Pengguna',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFC9E7),
        foregroundColor: const Color(0xFFC2185B),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFC9E7), Color(0xFFd6a7df), Color(0xFFa0c0ff)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterUsers,
                  style: const TextStyle(color: Color(0xFFC2185B)),
                  decoration: InputDecoration(
                    hintText: 'Cari pengguna berdasarkan nama/email...',
                    hintStyle: const TextStyle(color: Colors.black38),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFFC2185B),
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: Color(0xFFC2185B),
                            ),
                            onPressed: () {
                              _searchController.clear();
                              _filterUsers('');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.55),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFC2185B),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              // Users List
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFC2185B),
                        ),
                      )
                    : _filteredUsersList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 64,
                              color: const Color(0xFFC2185B).withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _rawUsersList.isEmpty
                                  ? 'Tidak ada data pengguna'
                                  : 'Tidak ditemukan pengguna yang cocok',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        color: const Color(0xFFC2185B),
                        backgroundColor: Colors.white,
                        onRefresh: _loadUsers,
                        child: ListView.builder(
                          itemCount: _filteredUsersList.length,
                          itemBuilder: (context, index) {
                            final userMap =
                                _filteredUsersList[index]
                                    as Map<String, dynamic>;
                            return _buildUserCard(userMap);
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
