import 'package:flutter/material.dart';

/// En-tête personnalisé réutilisable pour les écrans
/// Utilisé dans HomeScreen et autres écrans pour afficher un titre et un sous-titre.
/// Fournit une mise en page cohérente avec le thème de l'application.
class CustomHeader extends StatelessWidget {
  /// Le titre à afficher
  final String title;

  /// Le sous-titre ou la description
  final String subtitle;

  /// Crée un [CustomHeader]
  const CustomHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
