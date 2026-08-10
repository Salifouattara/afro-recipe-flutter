import 'package:flutter/material.dart';

/// Bouton d'action personnalisé avec icône et libellé
/// Utilisé pour les actions de navigation et les soumissions de formulaires.
/// Fournit un style cohérent avec le thème Material 3 de l'application.
class ActionNavButton extends StatelessWidget {
  /// Le texte du bouton
  final String label;

  /// L'icône à afficher avant le texte
  final IconData icon;

  /// Callback appelé quand le bouton est pressé
  final VoidCallback onPressed;

  /// Crée un [ActionNavButton]
  const ActionNavButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
