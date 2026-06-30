import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:latihan_flutter_b6/latihan/day36/services/auth_service.dart';
import 'package:latihan_flutter_b6/latihan/day36/services/dio_client.dart';
import 'package:latihan_flutter_b6/latihan/day36/services/token_storage.dart';
import 'package:latihan_flutter_b6/latihan/day36/views/register_page.dart';
import 'package:latihan_flutter_b6/latihan/day36/views/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AuthService _authService;
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _authService = AuthService(createDioClient());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await _authService.login({
        'email': _emailController.text.trim(),
        'password': _passwordController.text,
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
      final message = e.response?.data['message'] ?? 'Login gagal';
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message.toString()),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
      errorStyle: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
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
                colors: [Color(0xFFFFC9E7), Color(0xFFd6a7df), Color(0xFFa0c0ff)],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.lock_outline, size: 80, color: Color(0xFFC2185B)),
                        const SizedBox(height: 16),
                        const Text(
                          'Masuk ke Akun Anda',
                          style: TextStyle(
                            color: Color(0xFFC2185B),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Silakan masukkan email dan password',
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                        const SizedBox(height: 40),

                        // Email
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Color(0xFFC2185B)),
                          decoration: _inputDecoration(hint: 'Email'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email wajib diisi';
                            }
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'Email tidak valid';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Password
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: const TextStyle(color: Color(0xFFC2185B)),
                          decoration: _inputDecoration(
                            hint: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                color: const Color(0xFFC2185B),
                              ),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password wajib diisi';
                            }
                            if (value.length < 6) {
                              return 'Password minimal 6 karakter';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC2185B),
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: const Color(0xFFC2185B).withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                            ),
                            child: const Text(
                              'Masuk',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Register Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Belum punya akun? ',
                              style: TextStyle(color: Colors.black54),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                                );
                              },
                              child: const Text(
                                'Daftar di sini',
                                style: TextStyle(
                                  color: Color(0xFFC2185B),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                      'Menghubungkan...',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
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
