# Rencana Implementasi Sistem Autentikasi & Manajemen Profil (Absensi Day 36)

Dokumen ini berisi spesifikasi teknis dan rencana implementasi terperinci untuk 6 fitur utama yang akan diintegrasikan menggunakan Dio, Retrofit, dan Flutter. Dokumen ini dapat diimpor langsung ke platform Anda (seperti Opus).

---

## 1. Fitur: Login

### A. Deskripsi Fitur
Mengautentikasi pengguna menggunakan email dan kata sandi, menerima token autentikasi, serta menyimpannya secara aman di perangkat lokal menggunakan `TokenStorage` agar pengguna tidak perlu melakukan login ulang saat membuka aplikasi kembali (*persistence login*).

### B. Spesifikasi API
*   **Endpoint:** `POST /api/login`
*   **Request Body (JSON):**
    ```json
    {
      "email": "user@example.com",
      "password": "Password123!"
    }
    ```
*   **Method Signature:** 
    `Future<AuthResponse> login(@Body() Map<String, dynamic> body);`
*   **Pemetaan Response:** `AuthResponse` -> `Data` -> `token` & `User`.

### C. Alur Logika Bisnis & UI
1.  **Validasi Form:** Email harus valid secara regex (`emailRegex`), password minimal 8 karakter.
2.  **State Loading:** Tombol masuk berubah menjadi loading indicator (`CircularProgressIndicator`) saat request dikirim.
3.  **Sukses (200 OK):** Simpan token menggunakan `TokenStorage.saveToken(token)` dan navigasikan ke halaman Profil (`ProfilePage`) menggunakan `Navigator.pushReplacement`.
4.  **Gagal (401/404/422):** Tangkap error response, lalu tampilkan pesan error dari API menggunakan `SnackBar` berwarna merah dengan gaya floating.

---

## 2. Fitur: Register

### A. Deskripsi Fitur
Mendaftarkan pengguna baru ke dalam angkatan (*batch*) dan kelas pelatihan (*training*) tertentu, lalu otomatis menyimpan token autentikasi pasca-registrasi.

### B. Spesifikasi API
*   **Endpoint:** `POST /api/register`
*   **Request Body (JSON):**
    ```json
    {
      "name": "Nama Pengguna",
      "email": "user@example.com",
      "password": "Password123!",
      "jenis_kelamin": "L", // "L" atau "P"
      "profile_photo": "", // Opsional (Base64 string)
      "batch_id": 1,
      "training_id": 1
    }
    ```
*   **Method Signature:**
    `Future<AuthResponse> register(@Body() Map<String, dynamic> body);`
*   **Pemetaan Response:** `AuthResponse`.

### C. Alur Logika Bisnis & UI
1.  **Dropdown Data Binding:** Pengguna memilih pelatihan (*training*) dan angkatan (*batch*) dari pilihan dropdown yang nilainya ditarik secara dinamis dari API.
2.  **Validasi:** Seluruh input form wajib diisi dan divalidasi.
3.  **Sukses (200 OK):** Simpan token yang diterima dan arahkan pengguna langsung ke halaman Profil utama.

---

## 3. Fitur: Get Profile

### A. Deskripsi Fitur
Mengambil data profil lengkap pengguna yang sedang aktif dari server untuk ditampilkan pada halaman profil pribadi.

### B. Spesifikasi API
*   **Endpoint:** `GET /api/profile`
*   **Headers:** `Authorization: Bearer <token>`
*   **Method Signature:**
    `Future<ProfileResponse> getProfile();`
*   **Pemetaan Response:** `ProfileResponse` -> `UserModel`.

### C. Alur Logika Bisnis & UI
1.  **Autentikasi Header:** Token diambil otomatis dari `TokenStorage` via `InterceptorsWrapper` di `DioClient` lalu disematkan di header.
2.  **Shimmer/Loading State:** Menampilkan loading placeholder (atau Shimmer effect) saat memuat profil.
3.  **Tampilan Data:** Profil menampilkan Foto Profil (melingkar), Nama, Email, Jenis Kelamin, Detail Pelatihan, dan Angkatan.

---

## 4. Fitur: Update Profile (Update Data & Foto)

### A. Deskripsi Fitur
Memperbarui informasi profil pengguna (seperti nama) dan mengunggah foto profil baru.

### B. Spesifikasi API
*   **Update Nama:**
    *   **Endpoint:** `PUT /api/profile`
    *   **Request Body:** `{"name": "Nama Baru"}`
    *   **Method Signature:** `Future<ProfileResponse> updateProfile(@Body() Map<String, dynamic> body);`
*   **Update Foto Profil:**
    *   **Endpoint:** `PUT /api/profile/photo`
    *   **Request Body:** `{"profile_photo": "data:image/png;base64,..."}`
    *   **Method Signature:** `Future<ProfileResponse> updatePhotoProfile(@Body() Map<String, dynamic> body);`
*   **Pemetaan Response:** `ProfileResponse`.

### C. Alur Logika Bisnis & UI
1.  **Ganti Foto:** Mengetuk avatar membuka `ImagePicker` untuk memilih foto dari galeri/kamera. File gambar kemudian diubah menjadi format Base64 data URI sebelum dikirim.
2.  **Ganti Nama:** Form nama terisi otomatis (*pre-populated*) dengan nama lama, pengguna tinggal memperbarui lalu menekan simpan.
3.  **Callback Refresh:** Setelah pembaruan sukses, data pada halaman Profil utama otomatis diperbarui menggunakan state callback.

---

## 5. Fitur: Get Trainings

### A. Deskripsi Fitur
Mengambil daftar pelatihan (*trainings*) yang tersedia dari server untuk mengisi opsi pilihan dropdown pada halaman Registrasi.

### B. Spesifikasi API
*   **Endpoint:** `GET /api/trainings`
*   **Method Signature:**
    `Future<TrainingsResponse> getTrainings();`
*   **Pemetaan Response:** `TrainingsResponse` -> `List<Training>`.

### C. Alur Logika Bisnis & UI
1.  **Lazy Loading:** Data ditarik hanya pada saat halaman Register diinisialisasi (`initState`).
2.  **Data mapping:** Map data dari `List<Training>` ke elemen `DropdownMenuItem<int>`. Nilai `id` disimpan sebagai value dropdown, dan `title` ditampilkan sebagai teks.

---

## 6. Fitur: Get Batches

### A. Deskripsi Fitur
Mengambil daftar angkatan (*batches*) yang aktif dari server untuk mengisi opsi pilihan dropdown pada halaman Registrasi.

### B. Spesifikasi API
*   **Endpoint:** `GET /api/batches`
*   **Method Signature:**
    `Future<BatchesResponse> getBatches();`
*   **Pemetaan Response:** `BatchesResponse` -> `List<Batch>`.

### C. Alur Logika Bisnis & UI
1.  **Lazy Loading:** Data ditarik pada `initState` halaman Register bersamaan dengan data pelatihan.
2.  **Data mapping:** Map data dari `List<Batch>` ke elemen `DropdownMenuItem<int>` di mana value diisi dengan `id` angkatan dan label diisi dengan teks nama angkatan (misal: "Angkatan 1").
