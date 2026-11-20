// ============================================================================
// FILE : views/profile_screen.dart
// ISI  : username (SharedPreferences), jumlah favorit (Hive), tombol logout.
//
// [TETAP] Tidak bergantung API.
// [GANTI-SOAL] yang ditampilkan: soal ini 'Username' dan 'Anime Disukai'.
//   Soal keranjang -> 'Email' dan 'Jumlah Barang di Keranjang'.
// ============================================================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

// import '../controllers/favorite_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.put(AuthController(), permanent: true);
    // final FavoriteController favorite =
    //     Get.put(FavoriteController(), permanent: true);

    return Scaffold(
      appBar: AppBar(title: const Text('Profil'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 56)),
            const SizedBox(height: 24),
            // Obx karena username dan jumlah favorit bisa berubah
            Obx(
              () => Column(
                children: [
                  // username dari SharedPreferences
                  _row('Username : VoldemortGoat', auth.username),
                  // jumlah favorit dari Hive
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 164, 213, 228),
                  foregroundColor: Colors.white,
                ),
                onPressed: auth.logout,
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
