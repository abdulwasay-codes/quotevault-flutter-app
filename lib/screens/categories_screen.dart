import 'package:flutter/material.dart';
import 'category_quotes_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Map<String, String>> quotes;

  const CategoriesScreen({super.key, required this.quotes});

  @override
  Widget build(BuildContext context) {
    final categories = ["Success", "Motivation", "Discipline", "Growth"];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Quote Categories"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.amber,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          final count = quotes
              .where((quote) => quote["category"] == category)
              .length;

          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.amber),
            ),

            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryQuotesScreen(
                      category: category,
                      quotes: quotes,
                    ),
                  ),
                );
              },
              leading: const Icon(Icons.category, color: Colors.amber),
              title: Text(
                category,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "$count quotes",
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.amber,
              ),
            ),
          );
        },
      ),
    );
  }
}
