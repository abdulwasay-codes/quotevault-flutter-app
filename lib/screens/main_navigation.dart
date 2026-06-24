import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'favorites_screen.dart';
import 'categories_screen.dart';
import 'search_screen.dart';
import 'about_screen.dart';
import '../data/quotes_data.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;
  final quotes = QuotesData.quotes;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const FavoritesScreen(),
      CategoriesScreen(quotes: quotes),
      const SearchScreen(),
      const AboutScreen(),
    ];

    return PopScope(
      canPop: selectedIndex == 0,
      onPopInvoked: (didPop) {
        if (!didPop && selectedIndex != 0) {
          setState(() {
            selectedIndex = 0;
          });
        }
      },
      child: Scaffold(
        body: screens[selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.white54,
          type: BottomNavigationBarType.fixed,

          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },

          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),

            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),

            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
          ],
        ),
      ),
    );
  }
}
