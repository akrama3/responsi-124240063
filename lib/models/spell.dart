class Spell {
  final int index;
  final String spell;
  final String use;

  Spell({required this.index, required this.spell, required this.use});

  // factory constructor untuk membuat Spell dari JSON
  factory Spell.fromJson(Map<String, dynamic> jsonData) {
    return Spell(
      index: jsonData['index'] ?? 0,
      spell: jsonData['spell'] ?? '',
      use: jsonData['use'] ?? '',
    );
  }

  // diubah menjadi Map agar bisa disimpan di Hive
  Map<String, dynamic> toJson() {
    return {'index': index, 'spell': spell, 'use': use};
  }
}
