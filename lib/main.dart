import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'data/favorites_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FavoritesData.loadFavorites();

  runApp(const QuoteApp());
}

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuoteVault',
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
