import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> openGitHub() async {
    final Uri url = Uri.parse('https://github.com/abdulwasay-codes');

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  Future<void> openLinkedIn() async {
    final Uri url = Uri.parse('https://linkedin.com/in/abdul-wasay-b106ab373');

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("About QuoteVault"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.auto_awesome, color: Colors.amber, size: 80),

            const SizedBox(height: 15),

            const Text(
              "QuoteVault",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Your Daily Dose of Motivation",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),

            const SizedBox(height: 30),

            // Version Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Version",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "1.0.0",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Features Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Features",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),

                  Text("✓ Favorites", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 6),

                  Text("✓ Categories", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 6),

                  Text(
                    "✓ Quote Sharing",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 6),

                  Text("✓ Quote Search", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 6),

                  Text(
                    "✓ Persistent Favorites",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Developer Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Developer",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),

                  Text(
                    "Abdul Wasay",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  SizedBox(height: 6),

                  Text(
                    "Flutter Developer",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: openGitHub,
                  icon: const Icon(Icons.code),
                  label: const Text("GitHub"),
                ),

                const SizedBox(width: 12),

                OutlinedButton.icon(
                  onPressed: openLinkedIn,
                  icon: const Icon(Icons.person),
                  label: const Text("LinkedIn"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
