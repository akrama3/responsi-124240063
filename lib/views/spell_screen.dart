import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/spell_controller.dart';
import 'book_screen.dart';
import 'favorite_screen.dart';

class SpellScreen extends StatelessWidget {
  const SpellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SpellController controller = Get.put(SpellController());
    final AuthController auth = Get.put(AuthController(), permanent: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Harry Potter Spells Gallery'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: auth.logout),
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
          itemCount: controller.spells.length,
          itemBuilder: (context, index) {
            final spell = controller.spells[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.book),
                title: Text(
                  spell.spell,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(spell.use),
                // Obx di sini agar warna hati berubah saat favorite di-toggle
                trailing: Obx(
                  () => IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: controller.isFavorite(spell.index)
                          ? Colors.red
                          : Colors.black54,
                    ),
                    onPressed: () {
                      controller.toggleFavorite(spell);
                    },
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const FavoriteScreen());
        },
        child: const Icon(Icons.favorite, color: Colors.red),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton(
            onPressed: () {
              Get.off(() => const BookScreen());
            },
            child: const Text('Books'),
          ),
        ),
      ),
    );
  }
}
