import 'package:hive_flutter/hive_flutter.dart';
import '../models/spell.dart';

// Penyimpanan spell favorit di Hive.
// Spell disimpan sebagai Map dengan key = index spell.
class FavoriteService {
  static const String boxName = 'favorite_spells';

  final Box _box = Hive.box(boxName);

  List<Spell> getAll() {
    List<Spell> result = [];
    for (var item in _box.values) {
      result.add(Spell.fromJson(Map<String, dynamic>.from(item)));
    }
    return result;
  }

  Future<void> add(Spell spell) async {
    await _box.put(spell.index, spell.toJson());
  }

  Future<void> remove(int index) async {
    await _box.delete(index);
  }
}
