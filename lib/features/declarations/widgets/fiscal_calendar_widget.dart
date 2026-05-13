import 'package:flutter/material.dart';
import 'dart:math'; // 1. Import nécessaire pour le Random

class FiscalCalendarWidget extends StatelessWidget {
  const FiscalCalendarWidget({super.key});

  // 2. Fonction qui génère un nombre aléatoire entre 1 et 15 jours
  int _getRandomDays() {
    return Random().nextInt(15) + 1;
  }

  @override
  Widget build(BuildContext context) {
    int remainingDays = _getRandomDays(); // On génère à chaque reconstruction

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.notifications_active, color: Colors.red),
        ),
        title: const Text(
          "Date limite TVA",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // 3. Affichage dynamique du texte
        subtitle: Text(
          "Expire dans $remainingDays jours",
          style: TextStyle(
            color: remainingDays <= 3 ? Colors.red : Colors.grey[600],
            fontWeight: remainingDays <= 3
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Action lors du clic sur le rappel
        },
      ),
    );
  }
}
