import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/book.dart';
import '../services/book_service.dart';

class BookController extends GetxController {
  // Dependency
  final BookService _bookService = BookService();

  // State (variabel reaktif)
  final RxList<Book> _books = <Book>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  // Getter
  List<Book> get books => _books;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  // Lifecycle
  @override
  void onInit() {
    _retrieveData();
    super.onInit();
  }

  // Logika: mengambil data dari API
  Future<void> _retrieveData() async {
    try {
      _isLoading.value = true;
      final data = await _bookService.fetchBooks();
      _books.assignAll(data);
    } catch (e) {
      throw Exception(e);
    } finally {
      _isLoading.value = false;
    }
  }
}
