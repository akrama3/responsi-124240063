import 'dart:convert';
import 'package:http/http.dart' as http;
import '../API/api_endpoints.dart';
import '../models/spell.dart';

class SpellService {
  final Uri _url = Uri.parse(ApiEndpoints.spells);

  Future<List<Spell>> fetchSpells() async {
    final response = await http.get(_url);
    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body);
      return result.map((item) => Spell.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load spells');
    }
  }
}
