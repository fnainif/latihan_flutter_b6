import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latihan_flutter_b6/latihan/day36/models/user_model.dart';
import 'package:latihan_flutter_b6/latihan/day36/services/auth_service.dart';
import 'package:latihan_flutter_b6/latihan/day36/services/dio_client.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel? user;
  const EditProfilePage({super.key, this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AuthService _authService;

  bool _isLoading = false;
  bool _isUploadingPhoto = false;
  bool _hasChanges = false;
  bool _obscurePassword = true;
  String? _profilePhotoUrl;

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

  @override
  void initState() {
    super.initState();
    _authService = AuthService(createDioClient());
    _nameController.text = widget.user?.name ?? '';
    _emailController.text = widget.user?.email ?? '';
    _profilePhotoUrl = _getFormattedPhotoUrl(widget.user?.profilePhoto);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFC2185B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pilih Sumber Foto',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.white),
              title: const Text(
                'Ambil dari Kamera',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(ctx);
                _pickAndUploadImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.white),
              title: const Text(
                'Pilih dari Galeri',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(ctx);
                _pickAndUploadImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Future<void> _pickAndUploadImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, imageQuality: 70);
    if (picked == null) return;

    setState(() => _isUploadingPhoto = true);

    try {
      final bytes = await File(picked.path).readAsBytes();
      final base64Str = base64Encode(bytes);
      final ext = picked.path.split('.').last.toLowerCase();
      final dataUri = 'data:image/$ext;base64,$base64Str';

      final response = await _authService.updatePhotoProfile({
        'profile_photo': dataUri,
      });

      if (mounted) {
        setState(() {
          _hasChanges = true;
          _profilePhotoUrl = _getFormattedPhotoUrl(
            response.data?.profilePhoto,
          ); // Simpan URL foto profil baru hasil format
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Foto profil berhasil diperbarui'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } on DioException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal upload foto: ${e.response?.data['message'] ?? e.message}',
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal upload foto: $e'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploadingPhoto = false);
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final Map<String, dynamic> body = {
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
      };
      if (_passwordController.text.isNotEmpty) {
        body['password'] = _passwordController.text;
      }

      await _authService.updateProfile(body);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Profil berhasil diperbarui'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        Navigator.pop(context, true);
      }
    } on DioException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal menyimpan: ${e.response?.data['message'] ?? e.message}',
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan: $e'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildAvatar() {
    final hasNetworkPhoto =
        _profilePhotoUrl != null &&
        _profilePhotoUrl!.isNotEmpty &&
        _profilePhotoUrl!.startsWith('http');
    final initial = (widget.user?.name ?? '?')[0].toUpperCase();

    return GestureDetector(
      onTap: _isUploadingPhoto ? null : _showImagePickerOptions,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 55,
            backgroundImage: hasNetworkPhoto
                ? NetworkImage(_profilePhotoUrl!)
                : null,
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
          if (_isUploadingPhoto)
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFC2185B),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showOverlay = _isLoading || _isUploadingPhoto;
    final overlayText = _isUploadingPhoto
        ? 'Mengunggah Foto...'
        : 'Menyimpan Perubahan...';

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context, _hasChanges);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Profil',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFFFC9E7),
          foregroundColor: const Color(0xFFC2185B),
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFC9E7),
                    Color(0xFFd6a7df),
                    Color(0xFFa0c0ff),
                  ],
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildAvatar(),
                        const SizedBox(height: 8),
                        const Text(
                          'Ketuk foto untuk mengganti',
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                        const SizedBox(height: 32),

                        // Name Field
                        TextFormField(
                          controller: _nameController,
                          style: const TextStyle(color: Color(0xFFC2185B)),
                          decoration: InputDecoration(
                            labelText: 'Nama',
                            labelStyle: const TextStyle(color: Colors.black54),
                            hintText: 'Masukkan nama baru',
                            hintStyle: const TextStyle(color: Colors.black38),
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
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.redAccent,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.redAccent,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            errorStyle: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Nama wajib diisi'
                              : null,
                        ),
                        const SizedBox(height: 16),

                        // Email Field
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Color(0xFFC2185B)),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(color: Colors.black54),
                            hintText: 'Masukkan email baru',
                            hintStyle: const TextStyle(color: Colors.black38),
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
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.redAccent,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.redAccent,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            errorStyle: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty)
                              return 'Email wajib diisi';
                            if (!v.contains('@') || !v.contains('.'))
                              return 'Email tidak valid';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Password Field (Optional)
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: const TextStyle(color: Color(0xFFC2185B)),
                          decoration: InputDecoration(
                            labelText: 'Password Baru (Opsional)',
                            labelStyle: const TextStyle(color: Colors.black54),
                            hintText: 'Kosongkan jika tidak ingin mengubah',
                            hintStyle: const TextStyle(color: Colors.black38),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.55),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xFFC2185B),
                              ),
                              onPressed: () => setState(
                                () => _obscurePassword = !_obscurePassword,
                              ),
                            ),
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
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.redAccent,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.redAccent,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            errorStyle: const TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          validator: (v) {
                            if (v != null && v.isNotEmpty && v.length < 6) {
                              return 'Password minimal 6 karakter';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),

                        // Save Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: showOverlay ? null : _saveProfile,
                            icon: const Icon(Icons.save),
                            label: const Text(
                              'Simpan Perubahan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC2185B),
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: const Color(
                                0xFFC2185B,
                              ).withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (showOverlay)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(color: Color(0xFFFFC9E7)),
                      const SizedBox(height: 16),
                      Text(
                        overlayText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
