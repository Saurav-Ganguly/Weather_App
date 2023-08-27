import 'package:flutter/material.dart';

class ForcastCard extends StatelessWidget {
  final String time;
  final IconData forcastIcon;
  final String temp;
  const ForcastCard({
    required this.time,
    required this.forcastIcon,
    required this.temp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Icon(
              forcastIcon,
              size: 32,
            ),
            const SizedBox(height: 10),
            Text(
              temp,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
