import '../data/quotes_data.dart';
import '../data/favorites_data.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final quotes = QuotesData.quotes;

  int currentIndex = 0;
  int quotesViewed = 1;

  Future<void> loadViewedCount() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      quotesViewed = prefs.getInt('quotesViewed') ?? 1;
    });
  }

  Future<void> saveViewedCount() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('quotesViewed', quotesViewed);
  }

  bool isFavorite = false;
  String selectedCategory = "All";

  final List<String> categories = [
    "All",
    "Success",
    "Motivation",
    "Discipline",
    "Growth",
  ];

  @override
  void initState() {
    super.initState();

    loadViewedCount();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    await FavoritesData.loadFavorites();

    setState(() {});
  }

  void generateQuote() {
    List<Map<String, String>> filteredQuotes = selectedCategory == "All"
        ? quotes
        : quotes
              .where((quote) => quote["category"] == selectedCategory)
              .toList();

    setState(() {
      currentIndex = Random().nextInt(filteredQuotes.length);

      quotesViewed++;
      saveViewedCount();
      isFavorite = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredQuotes = selectedCategory == "All"
        ? quotes
        : quotes
              .where((quote) => quote["category"] == selectedCategory)
              .toList();

    final currentQuote = filteredQuotes[currentIndex % filteredQuotes.length];

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000000), Color(0xFF111111), Color(0xFF1A1A1A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.auto_awesome, color: Colors.amber, size: 65),

                const SizedBox(height: 12),

                const Text(
                  'QuoteVault',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Your Daily Dose of Motivation',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),

                const SizedBox(height: 8),

                Text(
                  'Quotes Viewed: $quotesViewed',
                  style: const TextStyle(color: Colors.white54, fontSize: 14),
                ),

                const SizedBox(height: 30),
                const SizedBox(height: 20),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: categories.map((category) {
                    return ChoiceChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      selectedColor: Colors.amber,
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = category;
                        });
                        generateQuote();
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 25),

                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.amber, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent.withOpacity(0.25),
                        blurRadius: 35,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.format_quote,
                        color: Colors.amber,
                        size: 50,
                      ),

                      const SizedBox(height: 15),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          '"${currentQuote["quote"]}"',
                          key: ValueKey(currentQuote["quote"]),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          "- ${currentQuote["author"]}",
                          key: ValueKey(currentQuote["author"]),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.amber,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () async {
                              Clipboard.setData(
                                ClipboardData(text: currentQuote["quote"]!),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Quote copied!")),
                              );
                            },
                            icon: const Icon(Icons.copy),
                            label: const Text("Copy"),
                          ),

                          const SizedBox(width: 12),

                          IconButton(
                            onPressed: () async {
                              setState(() {
                                if (!FavoritesData.favoriteQuotes.contains(
                                  currentQuote,
                                )) {
                                  FavoritesData.favoriteQuotes.add(
                                    currentQuote,
                                  );
                                  isFavorite = true;
                                } else {
                                  FavoritesData.favoriteQuotes.remove(
                                    currentQuote,
                                  );
                                  isFavorite = false;
                                }
                              });

                              await FavoritesData.saveFavorites();
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.amber : Colors.white,
                            ),
                          ),

                          const SizedBox(width: 12),

                          OutlinedButton.icon(
                            onPressed: () {
                              Share.share(
                                '"${currentQuote["quote"]}"\n\n'
                                '- ${currentQuote["author"]}\n\n'
                                'Shared from QuoteVault ✨',
                              );
                            },
                            icon: const Icon(Icons.share),
                            label: const Text("Share"),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: generateQuote,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(220, 55),
                        ),
                        child: const Text(
                          "✨ NEW QUOTE",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
