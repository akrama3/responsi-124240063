import 'package:flutter/material.dart';

import '../models/book.dart';

class DetailScreen extends StatelessWidget {
  final Book book;
  const DetailScreen({super.key, required this.book});

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          Text(
            value.isEmpty ? '-' : value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                book.cover,
                height: 320,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, size: 120),
              ),
            ),
            const SizedBox(height: 16),
            _info('Title', book.title),
            _info('Original Title', book.originalTitle),
            _info('Release Date', book.releaseDate),
            _info('Total Page', book.pages.toString()),
            _info('Deskripsi :', book.description),
            _info('Index', book.index.toString()),
          ],
        ),
      ),
    );
  }
}
