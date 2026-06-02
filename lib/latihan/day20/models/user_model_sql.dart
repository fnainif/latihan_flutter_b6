import 'dart:convert';

class UserModelSql {
  final int? id;
  final String nama;
  final String email;
  final String password;
  final String noHp;
  final String alamat;
  final String instansi;

  UserModelSql({
    this.id,
    required this.nama,
    required this.email,
    required this.password,
    required this.noHp,
    required this.alamat,
    required this.instansi,
  });

  // Mengubah data object ke Map (untuk disimpan ke database)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'email': email,
      'password': password,
      'no_hp': noHp, // Menyesuaikan nama kolom snake_case di DB
      'alamat': alamat,
      'instansi': instansi,
    };
  }

  // Mengubah Map dari database menjadi Object Dart
  factory UserModelSql.fromMap(Map<String, dynamic> map) {
    return UserModelSql(
      id: map['id'] != null ? map['id'] as int : null,
      nama: map['nama'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      noHp: map['no_hp'] as String,
      alamat: map['alamat'] as String,
      instansi: map['instansi'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModelSql.fromJson(String source) =>
      UserModelSql.fromMap(json.decode(source) as Map<String, dynamic>);
}
