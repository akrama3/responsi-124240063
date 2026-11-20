import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/favorite_service.dart';
import 'services/notification_service.dart';
import 'views/book_screen.dart';
import 'views/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive untuk menyimpan spell favorit
  await Hive.initFlutter();
  await Hive.openBox(FavoriteService.boxName);

  // Notifikasi lokal
  await NotificationService().init();

  // cek session login di Shared Preferences
  final loginData = await SharedPreferences.getInstance();
  final adaLogin = loginData.getBool('loginData') ?? false;

  runApp(MainApp(adaLogin: adaLogin));
}

class MainApp extends StatelessWidget {
  final bool adaLogin;
  const MainApp({super.key, required this.adaLogin});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Harry Potter App',
      debugShowCheckedModeBanner: false,
      home: adaLogin ? const BookScreen() : const LoginScreen(),
    );
  }
}
