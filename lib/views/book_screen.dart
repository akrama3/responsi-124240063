import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/profile_screen.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/book_controller.dart';
import 'detail_screen.dart';
import 'spell_screen.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookController controller = Get.put(BookController());
    final AuthController auth = Get.put(AuthController(), permanent: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Harry Potter Books'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: auth.logout),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () =>
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => ProfileScreen())),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: controller.books.length,
          itemBuilder: (context, index) {
            final book = controller.books[index];
            return Card(
              child: ListTile(
                leading: Image.network(
                  book.cover,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person, size: 40),
                ),
                title: Text(
                  book.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(book.releaseDate),
                onTap: () {
                  Get.to(() => DetailScreen(book: book));
                },
              ),
            );
          },
        );
      }),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton(
            onPressed: () {
              Get.off(() => const SpellScreen());
            },
            child: const Text('Spells'),
          ),
        ),
      ),
    );
  }
}
