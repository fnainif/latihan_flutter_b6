import 'package:flutter/material.dart';
import 'package:latihan_flutter_b6/latihan/day20/database/db_helper.dart';
import 'package:latihan_flutter_b6/latihan/day20/models/user_model_sql.dart';
import 'package:sqlite_viewer2/sqlite_viewer.dart';

class HomescreenDay20 extends StatefulWidget {
  const HomescreenDay20({super.key});

  @override
  State<HomescreenDay20> createState() => _HomescreenDay20State();
}

class _HomescreenDay20State extends State<HomescreenDay20> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nohpController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController instansiController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    nohpController.dispose();
    addressController.dispose();
    instansiController.dispose();
    super.dispose();
  }

  void register() async {
    final nama = nameController.text.trim();
    final email = emailController.text.trim();
    final pass = passwordController.text;
    final noHp = nohpController.text.trim();
    final alamat = addressController.text.trim();
    final instansi = instansiController.text.trim();

    if (_formKey.currentState!.validate()) {
      if (nama.isEmpty ||
          email.isEmpty ||
          pass.isEmpty ||
          noHp.isEmpty ||
          alamat.isEmpty ||
          instansi.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Isi semua field!')));
        return;
      }

      final user = UserModelSql(
        nama: nama,
        email: email,
        password: pass,
        noHp: noHp,
        alamat: alamat,
        instansi: instansi,
      );

      bool success = await DBHelper().registerUser(user);

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Registrasi Berhasil!')));

        nameController.clear();
        emailController.clear();
        passwordController.clear();
        nohpController.clear();
        addressController.clear();
        instansiController.clear();

        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registrasi Gagal! Email mungkin sudah terdaftar.'),
          ),
        );
      }
    }
  }

  void _showBottomSheet(BuildContext context, UserModelSql user) {
    final nameEditController = TextEditingController(text: user.nama);
    final emailEditController = TextEditingController(text: user.email);
    final passwordEditController = TextEditingController(text: user.password);
    final nohpEditController = TextEditingController(text: user.noHp);
    final addressEditController = TextEditingController(text: user.alamat);
    final instansiEditController = TextEditingController(text: user.instansi);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Kelola Pengguna',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameEditController,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailEditController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordEditController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nohpEditController,
                  decoration: const InputDecoration(
                    labelText: 'No. HP',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: addressEditController,
                  decoration: const InputDecoration(
                    labelText: 'Alamat',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: instansiEditController,
                  decoration: const InputDecoration(
                    labelText: 'Instansi',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (user.id != null) {
                          final updatedUser = UserModelSql(
                            id: user.id,
                            nama: nameEditController.text.trim(),
                            email: emailEditController.text.trim(),
                            password: passwordEditController.text,
                            noHp: nohpEditController.text.trim(),
                            alamat: addressEditController.text.trim(),
                            instansi: instansiEditController.text.trim(),
                          );

                          bool success = await DBHelper().updateUser(
                            updatedUser,
                          );
                          if (success && context.mounted) {
                            Navigator.pop(context);
                            setState(() {});
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Data berhasil diperbarui'),
                              ),
                            );
                          }
                        }
                      },
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      icon: const Icon(Icons.delete, color: Colors.white),
                      label: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (user.id != null) {
                          await DBHelper().deleteUser(user.id!);
                          if (context.mounted) {
                            Navigator.pop(context);
                            setState(() {});
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Data berhasil dihapus'),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar & Kelola Pengguna')),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            hintText: "Masukkan Nama",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Nama tidak boleh kosong";
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: "Masukkan Email",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Email tidak boleh kosong";
                            if (!value.contains('@'))
                              return "Format email tidak valid";
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            hintText: "Masukkan Password",
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Password tidak boleh kosong";
                            if (value.length < 6)
                              return "Password terlalu singkat";
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: nohpController,
                          decoration: const InputDecoration(
                            hintText: "Masukkan No. HP",
                          ),

                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: addressController,
                          decoration: const InputDecoration(
                            hintText: "Masukkan Alamat",
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: instansiController,
                          decoration: const InputDecoration(
                            hintText: "Masukkan Instansi",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: register,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                    ),
                    child: const Text("Tambah Pengguna"),
                  ),
                ],
              ),
            ),
          ),

          const Divider(thickness: 2),

          Expanded(
            flex: 2,
            child: FutureBuilder<List<UserModelSql>>(
              future: DBHelper().getAllUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Terjadi kesalahan: ${snapshot.error}'),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada data pengguna.'));
                }

                final daftarPengguna = snapshot.data!;
                return ListView.builder(
                  itemCount: daftarPengguna.length,
                  itemBuilder: (context, index) {
                    final user = daftarPengguna[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.person)),
                        title: Text(user.nama),
                        subtitle: Text(user.email),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.edit_document,
                            color: Colors.blueGrey,
                          ),
                          onPressed: () => _showBottomSheet(context, user),
                        ),
                        onTap: () => _showBottomSheet(context, user),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DatabaseList()),
                );
              },
              child: const Text("Lihat Database"),
            ),
          ),
        ],
      ),
    );
  }
}
