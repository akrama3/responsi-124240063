import 'dart:convert';

import 'package:http/http.dart' as http;

import '../API/api_endpoints.dart';
import '../models/book.dart';

class BookService {
  final Uri _url = Uri.parse(ApiEndpoints.books);

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(_url);
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      print(result);
      return result.map((item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Failed to lod Books');
    }
  }
}
