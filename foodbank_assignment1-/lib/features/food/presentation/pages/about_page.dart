import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // App icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.volunteer_activism,
                size: 60,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 16),

            // App name
            const Text(
              'Food Bank App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            // Version
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // About section
            _SectionCard(
              icon: Icons.info_outline,
              title: 'About This App',
              content: 'Food Bank App is a management tool designed to help '
                  'food banks track, manage, and update their inventory '
                  'of food items. It allows staff to add, edit, view, '
                  'and remove food items with ease.',
            ),

            const SizedBox(height: 16),

            // Features section
            _SectionCard(
              icon: Icons.star_outline,
              title: 'Features',
              content: '• Browse all available food items\n'
                  '• Add new food items to the inventory\n'
                  '• Edit existing food item details\n'
                  '• Delete items that are no longer available\n'
                  '• Search for specific food items quickly\n'
                  '• View detailed information for each item',
            ),

            const SizedBox(height: 16),

            // Tech stack
            _SectionCard(
              icon: Icons.code,
              title: 'Built With',
              content: '• Flutter — cross-platform UI framework\n'
                  '• Bloc — state management\n'
                  '• Dio — HTTP networking\n'
                  '• GetIt — dependency injection\n'
                  '• JSONPlaceholder — mock REST API',
            ),

            const SizedBox(height: 16),

            // Purpose
            _SectionCard(
              icon: Icons.favorite_outline,
              title: 'Our Mission',
              content: 'We believe no one should go hungry. This app was '
                  'built to support food bank volunteers and staff in '
                  'managing donations and supplies more efficiently, '
                  'so that help reaches those who need it most.',
            ),

            const SizedBox(height: 30),

            // Footer
            Text(
              '© 2024 Food Bank App. All rights reserved.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.green, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
