import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/day36/models/auth_response.dart';
import 'package:latihan_flutter_b6/latihan/day36/services/auth_service.dart';
import 'package:latihan_flutter_b6/latihan/day36/services/dio_client.dart';
import 'package:latihan_flutter_b6/latihan/day36/services/token_storage.dart';
import 'package:latihan_flutter_b6/latihan/day36/views/main_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AuthService _authService;

  bool _isLoading = false;
  bool _isLoadingDropdown = true;
  bool _obscurePassword = true;

  String? _selectedGender;
  int? _selectedTrainingId;
  int? _selectedBatchId;

  List<Training> _trainings = [];
  List<Batch> _batches = [];

  @override
  void initState() {
    super.initState();
    _authService = AuthService(createDioClient());
    _loadDropdownData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadDropdownData() async {
    setState(() => _isLoadingDropdown = true);
    try {
      final trainingsResp = await _authService.getTrainings();
      final batchesResp = await _authService.getBatches();
      if (mounted) {
        setState(() {
          _trainings = trainingsResp.data ?? [];
          _batches = batchesResp.data ?? [];
          _isLoadingDropdown = false;
        });
      }
    } on DioException catch (e) {
      if (mounted) {
        setState(() => _isLoadingDropdown = false);
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
        setState(() => _isLoadingDropdown = false);
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

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await _authService.register({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'password': _passwordController.text,
        'jenis_kelamin': _selectedGender,
        'profile_photo': '',
        'batch_id': _selectedBatchId,
        'training_id': _selectedTrainingId,
      });

      if (response.data?.token != null) {
        await TokenStorage.saveToken(response.data!.token!);
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainPage()),
          );
        }
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Registrasi gagal';
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message.toString()),
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
            content: Text('Terjadi kesalahan: $e'),
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

  InputDecoration _inputDecoration({required String hint, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black38),
      filled: true,
      fillColor: Colors.white.withOpacity(0.55),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFC2185B), width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      errorStyle: const TextStyle(
        color: Colors.redAccent,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                  vertical: 16,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Icon(
                        Icons.person_add_outlined,
                        size: 80,
                        color: Color(0xFFC2185B),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Buat Akun Baru',
                        style: TextStyle(
                          color: Color(0xFFC2185B),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Lengkapi data di bawah untuk mendaftar',
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                      const SizedBox(height: 32),

                      // Nama
                      TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Color(0xFFC2185B)),
                        decoration: _inputDecoration(hint: 'Nama Lengkap'),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Nama wajib diisi'
                            : null,
                      ),
                      const SizedBox(height: 14),

                      // Email
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Color(0xFFC2185B)),
                        decoration: _inputDecoration(hint: 'Email'),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty)
                            return 'Email wajib diisi';
                          if (!v.contains('@') || !v.contains('.'))
                            return 'Email tidak valid';
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      // Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: const TextStyle(color: Color(0xFFC2185B)),
                        decoration: _inputDecoration(
                          hint: 'Password',
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
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty)
                            return 'Password wajib diisi';
                          if (v.length < 6)
                            return 'Password minimal 6 karakter';
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),

                      // Jenis Kelamin
                      DropdownButtonFormField<String>(
                        initialValue: _selectedGender,
                        dropdownColor: const Color(0xFFd6a7df),
                        style: const TextStyle(color: Color(0xFFC2185B)),
                        iconEnabledColor: const Color(0xFFC2185B),
                        decoration: _inputDecoration(
                          hint: 'Pilih Jenis Kelamin',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'L',
                            child: Text('Laki-laki'),
                          ),
                          DropdownMenuItem(
                            value: 'P',
                            child: Text('Perempuan'),
                          ),
                        ],
                        onChanged: (v) => setState(() => _selectedGender = v),
                        validator: (v) =>
                            v == null ? 'Jenis kelamin wajib dipilih' : null,
                      ),
                      const SizedBox(height: 14),

                      // Pelatihan
                      DropdownButtonFormField<int>(
                        initialValue: _selectedTrainingId,
                        dropdownColor: const Color(0xFFd6a7df),
                        style: const TextStyle(color: Color(0xFFC2185B)),
                        iconEnabledColor: const Color(0xFFC2185B),
                        decoration: _inputDecoration(
                          hint: _isLoadingDropdown
                              ? 'Memuat data pelatihan...'
                              : 'Pilih Pelatihan',
                        ),
                        items: _trainings
                            .map(
                              (t) => DropdownMenuItem<int>(
                                value: t.id,
                                child: Text(
                                  t.title ?? '-',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: _isLoadingDropdown
                            ? null
                            : (v) => setState(() => _selectedTrainingId = v),
                        validator: (v) =>
                            v == null ? 'Pelatihan wajib dipilih' : null,
                      ),
                      const SizedBox(height: 14),

                      // Angkatan
                      DropdownButtonFormField<int>(
                        initialValue: _selectedBatchId,
                        dropdownColor: const Color(0xFFd6a7df),
                        style: const TextStyle(color: Color(0xFFC2185B)),
                        iconEnabledColor: const Color(0xFFC2185B),
                        decoration: _inputDecoration(
                          hint: _isLoadingDropdown
                              ? 'Memuat data angkatan...'
                              : 'Pilih Angkatan',
                        ),
                        items: _batches
                            .map(
                              (b) => DropdownMenuItem<int>(
                                value: b.id,
                                child: Text('Angkatan ${b.batchKe ?? "-"}'),
                              ),
                            )
                            .toList(),
                        onChanged: _isLoadingDropdown
                            ? null
                            : (v) => setState(() => _selectedBatchId = v),
                        validator: (v) =>
                            v == null ? 'Angkatan wajib dipilih' : null,
                      ),
                      const SizedBox(height: 28),

                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _register,
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
                          child: const Text(
                            'Daftar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sudah punya akun? ',
                            style: TextStyle(color: Colors.black54),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              'Masuk di sini',
                              style: TextStyle(
                                color: Color(0xFFC2185B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Color(0xFFFFC9E7)),
                    SizedBox(height: 16),
                    Text(
                      'Mendaftarkan Akun...',
                      style: TextStyle(
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
    );
  }
}
