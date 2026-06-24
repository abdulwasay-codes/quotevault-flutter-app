import 'package:flutter/material.dart';

class CategoryQuotesScreen extends StatelessWidget {
  final String category;
  final List<Map<String, String>> quotes;

  const CategoryQuotesScreen({
    super.key,
    required this.category,
    required this.quotes,
  });

  @override
  Widget build(BuildContext context) {
    final filteredQuotes =
        quotes.where((q) => q["category"] == category).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(category),
        backgroundColor: Colors.black,
        foregroundColor: Colors.amber,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredQuotes.length,
        itemBuilder: (context, index) {
          final quote = filteredQuotes[index];

          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.amber),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '"${quote["quote"]}"',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "- ${quote["author"]}",
                    style: const TextStyle(
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

