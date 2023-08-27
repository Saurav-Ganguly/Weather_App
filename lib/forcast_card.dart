import 'package:flutter/material.dart';

class ForcastCard extends StatelessWidget {
  const ForcastCard({
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
        child: const Column(
          children: [
            Text(
              '03:00',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Icon(
              Icons.cloud,
              size: 32,
            ),
            SizedBox(height: 10),
            Text(
              '300.67° K',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
