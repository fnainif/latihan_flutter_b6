import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latihan_flutter_b6/latihan/day36/models/user_model.dart';

class AccountDetailPage extends StatelessWidget {
  final UserModel user;

  const AccountDetailPage({super.key, required this.user});

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '-';
    try {
      // Format lokal Indonesia: dd MMMM yyyy, HH:mm
      return DateFormat('dd MMMM yyyy, HH:mm', 'id_ID').format(dateTime.toLocal());
    } catch (e) {
      // Fallback jika locale id_ID tidak diinisialisasi
      return DateFormat('dd-MM-yyyy, HH:mm').format(dateTime.toLocal());
    }
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFC2185B), size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFFC2185B),
                    fontSize: 15,
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

  @override
  Widget build(BuildContext context) {
    final genderText = user.jenisKelamin == 'L'
        ? 'Laki-laki'
        : (user.jenisKelamin == 'P' ? 'Perempuan' : '-');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Informasi Akun',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFC9E7),
        foregroundColor: const Color(0xFFC2185B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Icon(
                    Icons.account_box_outlined,
                    size: 80,
                    color: Color(0xFFC2185B),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Informasi Akun Lengkap',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC2185B),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                _buildDetailRow(
                  icon: Icons.fingerprint,
                  label: 'User ID',
                  value: user.id?.toString() ?? '-',
                ),
                _buildDetailRow(
                  icon: Icons.person_outline,
                  label: 'Nama Lengkap',
                  value: user.name ?? '-',
                ),
                _buildDetailRow(
                  icon: Icons.mail_outline,
                  label: 'Email',
                  value: user.email ?? '-',
                ),
                _buildDetailRow(
                  icon: Icons.transgender,
                  label: 'Jenis Kelamin',
                  value: genderText,
                ),
                _buildDetailRow(
                  icon: Icons.school_outlined,
                  label: 'Pelatihan',
                  value: user.training != null
                      ? '${user.training?.title} (ID: ${user.trainingId})'
                      : 'Tanpa Pelatihan (ID: ${user.trainingId ?? "-"})',
                ),
                _buildDetailRow(
                  icon: Icons.groups_outlined,
                  label: 'Angkatan',
                  value: user.batch != null
                      ? 'Angkatan ${user.batch?.batchKe} (ID: ${user.batchId})'
                      : 'Tanpa Angkatan (ID: ${user.batchId ?? "-"})',
                ),
                _buildDetailRow(
                  icon: Icons.event_available,
                  label: 'Tanggal Terdaftar',
                  value: _formatDateTime(user.createdAt),
                ),
                _buildDetailRow(
                  icon: Icons.update,
                  label: 'Terakhir Diperbarui',
                  value: _formatDateTime(user.updatedAt),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
