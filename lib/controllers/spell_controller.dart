import 'package:get/get.dart';
import '../models/spell.dart';
import '../services/favorite_service.dart';
import '../services/notification_service.dart';
import '../services/snackbar_service.dart';
import '../services/spell_service.dart';

class SpellController extends GetxController {
  // Dependency
  final SpellService _spellService = SpellService();
  final FavoriteService _favoriteService = FavoriteService();

  // State (variabel reaktif)
  final RxList<Spell> _spells = <Spell>[].obs;
  final RxList<Spell> _favorites = <Spell>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  // Getter
  List<Spell> get spells => _spells;
  List<Spell> get favorites => _favorites;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  // Lifecycle
  @override
  void onInit() {
    _favorites.assignAll(_favoriteService.getAll()); // dari Hive
    _retrieveData();
    super.onInit();
  }

  Future<void> _retrieveData() async {
    try {
      _isLoading.value = true;
      final data = await _spellService.fetchSpells();
      _spells.assignAll(data);
    } catch (e) {
      _errorMessage.value = 'Failed to load spells';
    } finally {
      _isLoading.value = false;
    }
  }

  bool isFavorite(int index) {
    return _favorites.any((spell) => spell.index == index);
  }

  // tombol favorite: tambah atau hapus dari Hive
  Future<void> toggleFavorite(Spell spell) async {
    if (isFavorite(spell.index)) {
      await _favoriteService.remove(spell.index);
      _favorites.removeWhere((item) => item.index == spell.index);
      SnackbarService.error('Remove!', '${spell.spell} removed from fav list');
    } else {
      await _favoriteService.add(spell);
      _favorites.add(spell);
      SnackbarService.success(
        'Add!',
        '${spell.spell} successfully added to fav list',
      );
    }
  }

  // hapus dari halaman Favorite, lalu tampilkan immediate notification
  Future<void> removeFavorite(Spell spell) async {
    await _favoriteService.remove(spell.index);
    _favorites.removeWhere((item) => item.index == spell.index);
    await NotificationService().showInstantNotification(
      title: 'Delete notification',
      body: 'You deleted ${spell.spell} from your fav list!',
    );
  }
}
