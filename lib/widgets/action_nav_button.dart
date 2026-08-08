import 'package:flutter/material.dart';

class ActionNavButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const ActionNavButton({super.key, required this.label, required this.icon, required this.onPressed});

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
