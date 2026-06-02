import 'package:latihan_flutter_b6/latihan/day20/models/user_model_sql.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'ppkd.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            email TEXT UNIQUE,
            password TEXT,
            no_hp TEXT,
            alamat TEXT,
            instansi TEXT
          )
        ''');
      },
    );
  }

  // Fungsi Register
  Future<bool> registerUser(UserModelSql pengguna) async {
    final db = await database;

    try {
      final id = await db.insert('users', pengguna.toMap());
      return id > 0;
    } catch (e) {
      return false;
    }
  }

  // Fungsi ini memeriksa apakah kombinasi email dan password cocok
  Future<UserModelSql?> loginUser(String email, String password) async {
    final db = await database;

    // Melakukan query untuk mencari user dengan email dan password yang sesuai
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    // Jika ditemukan, kembalikan data user tersebut (baris pertama)
    if (result.isNotEmpty) {
      return UserModelSql.fromMap(result.first);
    }

    // Jika tidak cocok, kembalikan null
    return null;
  }

  Future<List<UserModelSql>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query('users');

    return results.map((map) => UserModelSql.fromMap(map)).toList();
  }

  // Fungsi untuk menghapus user berdasarkan ID
  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // Fungsi untuk memperbarui data user
  Future<bool> updateUser(UserModelSql pengguna) async {
    final db = await database;
    try {
      int count = await db.update(
        'users',
        pengguna.toMap(),
        where: 'id = ?',
        whereArgs: [pengguna.id],
      );
      return count > 0;
    } catch (e) {
      return false;
    }
  }
}
