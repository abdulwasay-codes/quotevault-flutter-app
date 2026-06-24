import 'storage_service.dart';

class FavoritesData {
  static List<Map<String, String>> favoriteQuotes = [];

  static Future<void> loadFavorites() async {
    favoriteQuotes = await StorageService.loadFavorites();
  }

  static Future<void> saveFavorites() async {
    await StorageService.saveFavorites(favoriteQuotes);
  }
}