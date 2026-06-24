import 'package:flutter/material.dart';
import '../data/quotes_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    final results = QuotesData.quotes.where((quote) {
      final query = searchText.toLowerCase();

      return quote["quote"]!.toLowerCase().contains(query) ||
          quote["author"]!.toLowerCase().contains(query) ||
          quote["category"]!.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Search Quotes"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search quotes...",
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.amber),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final quote = results[index];

                return Card(
                  color: Colors.grey[900],
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      quote["quote"]!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "- ${quote["author"]}",
                      style: const TextStyle(color: Colors.amber),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
