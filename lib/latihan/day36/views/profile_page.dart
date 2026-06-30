import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/day36/models/user_model.dart';
import 'package:latihan_flutter_b6/latihan/day36/services/auth_service.dart';
import 'package:latihan_flutter_b6/latihan/day36/services/dio_client.dart';
import 'package:latihan_flutter_b6/latihan/day36/services/token_storage.dart';
import 'package:latihan_flutter_b6/latihan/day36/views/account_detail_page.dart';
import 'package:latihan_flutter_b6/latihan/day36/views/edit_profile_page.dart';
import 'package:latihan_flutter_b6/latihan/day36/views/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final AuthService _authService;
  UserModel? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _authService = AuthService(createDioClient());
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);
    try {
      final response = await _authService.getProfile();
      if (mounted) {
        setState(() {
          _user = response.data;
          _isLoading = false;
        });
      }
    } on DioException catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal memuat profil: ${e.response?.data['message'] ?? e.message}',
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
            content: Text('Gagal memuat profil: $e'),
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

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFC2185B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Konfirmasi Logout',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Apakah Anda yakin ingin keluar?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await TokenStorage.clearToken();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    }
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFC2185B), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFFC2185B),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? _getFormattedPhotoUrl(dynamic photo) {
    if (photo is! String || photo.isEmpty) return null;
    String url = photo;
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

  Widget _buildAvatar() {
    final photoUrl = _getFormattedPhotoUrl(_user?.profilePhoto);
    final hasNetworkPhoto = photoUrl != null && photoUrl.isNotEmpty;
    final initial = (_user?.name ?? '?')[0].toUpperCase();

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 55,
        backgroundImage: hasNetworkPhoto ? NetworkImage(photoUrl) : null,
        backgroundColor: hasNetworkPhoto ? null : Colors.transparent,
        child: hasNetworkPhoto
            ? null
            : Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFC9E7), Color(0xFFd6a7df)],
                  ),
                ),
                child: Center(
                  child: Text(
                    initial,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC2185B),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Profil Saya',
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Color(0xFFd6a7df),
      //   foregroundColor: const Color(0xFFC2185B),
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      // ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFC9E7), Color(0xFFd6a7df), Color(0xFFa0c0ff)],
          ),
        ),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFFC2185B)),
              )
            : _user == null
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.black54,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Gagal memuat profil',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC2185B),
                      ),
                      child: const Text(
                        'Coba Lagi',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.white60, Color(0xFFd6a7df)],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 80),
                          _buildAvatar(),
                          const SizedBox(height: 16),
                          Text(
                            _user!.name ?? '-',
                            style: const TextStyle(
                              color: Color(0xFFC2185B),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _user!.email ?? '-',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    _buildInfoCard(
                      'Jenis Kelamin',
                      _user!.jenisKelamin == 'L'
                          ? 'Laki-laki'
                          : (_user!.jenisKelamin == 'P' ? 'Perempuan' : '-'),
                      Icons.person,
                    ),
                    _buildInfoCard(
                      'Pelatihan',
                      _user!.training?.title ?? '-',
                      Icons.school,
                    ),
                    _buildInfoCard(
                      'Angkatan',
                      _user!.batch?.batchKe ?? '-',
                      Icons.groups,
                    ),
                    _buildInfoCard(
                      'Tanggal Daftar',
                      _user!.createdAt?.toLocal().toString().split(' ')[0] ??
                          '-',
                      Icons.calendar_today,
                    ),

                    const SizedBox(height: 24),

                    // Detail Informasi Akun Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (_user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AccountDetailPage(user: _user!),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.info_outline),
                          label: const Text(
                            'Detail Informasi Peserta',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.55),
                            foregroundColor: const Color(0xFFC2185B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                            elevation: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Edit Profile Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final result = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditProfilePage(user: _user),
                              ),
                            );
                            if (result == true) _loadProfile();
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text(
                            'Edit Profil',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC2185B),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Logout Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          onPressed: _logout,
                          icon: const Icon(Icons.logout),
                          label: const Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.redAccent,
                            backgroundColor: Colors.white.withOpacity(0.4),
                            side: const BorderSide(
                              color: Colors.redAccent,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
      ),
    );
  }
}
