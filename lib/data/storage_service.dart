import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String favoritesKey = "favorites";

  static Future<void> saveFavorites(
    List<Map<String, String>> favorites,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode(favorites);

    await prefs.setString(
      favoritesKey,
      jsonString,
    );
  }

  static Future<List<Map<String, String>>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(
      favoritesKey,
    );

    if (jsonString == null) {
      return [];
    }

    final List decoded =
        jsonDecode(jsonString);

    return decoded
        .map<Map<String, String>>(
          (item) =>
              Map<String, String>.from(item),
        )
        .toList();
  }
}
