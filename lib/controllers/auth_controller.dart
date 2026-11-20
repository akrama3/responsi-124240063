import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/snackbar_service.dart';
import '../views/book_screen.dart';
import '../views/login_screen.dart';

class AuthController extends GetxController {
  // login hardcoded
  final String _validUsername = 'VoldemortGoat';
  final String _validPassword = '124240063';

  final RxString _username = ''.obs;
  String get username => _username.value;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      SnackbarService.error('Failed!', 'Username and password must be filled');
      return;
    }

    if (username == _validUsername && password == _validPassword) {
      // simpan session di Shared Preferences
      final loginData = await SharedPreferences.getInstance();
      await loginData.setBool('loginData', true);

      usernameController.clear();
      passwordController.clear();
      Get.offAll(() => const BookScreen());
      SnackbarService.success('Success!', 'Logged in successfully');
    } else {
      SnackbarService.error('Failed!', 'Invalid username or password');
    }
  }

  Future<void> logout() async {
    final loginData = await SharedPreferences.getInstance();
    await loginData.setBool('loginData', false);

    Get.offAll(() => const LoginScreen());
    SnackbarService.success('Success!', 'Logged out successfully');
  }
}
