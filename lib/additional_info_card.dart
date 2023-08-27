import 'package:flutter/material.dart';

class AdditionalInfoCard extends StatelessWidget {
  final IconData cardIcon;
  final String cardValue;
  final String cardTitle;
  const AdditionalInfoCard({
    super.key,
    required this.cardIcon,
    required this.cardTitle,
    required this.cardValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          cardIcon,
          size: 40,
        ),
        const SizedBox(height: 5),
        Text(
          cardTitle,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        Text(
          cardValue,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
