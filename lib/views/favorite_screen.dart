import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/spell_controller.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SpellController controller = Get.find<SpellController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Spell')),
      body: Obx(() {
        final favorites = controller.favorites;
        if (favorites.isEmpty) {
          return const Center(child: Text('No favorite spells yet'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final spell = favorites[index];
            return Card(
              child: ListTile(
                leading: const Icon(Icons.book),
                title: Text(
                  spell.spell,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(spell.use),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    controller.removeFavorite(spell);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
