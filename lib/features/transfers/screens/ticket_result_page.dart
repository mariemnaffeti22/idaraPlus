import 'dart:math'; // 1. Import nécessaire pour générer un chiffre aléatoire
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketResultPage extends StatelessWidget {
  final String serviceName;
  final String montant;

  const TicketResultPage({
    super.key,
    required this.serviceName,
    required this.montant,
  });

  @override
  Widget build(BuildContext context) {
    // 2. Générer un numéro de ticket aléatoire (ex: 8592)
    final String ticketId = (Random().nextInt(8999) + 1000).toString();

    // 3. Créer la donnée qui sera cachée dans le QR Code
    final String qrData =
        "ID-POSTE-$ticketId|Service:$serviceName|Montant:$montant DT";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Votre Ticket")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: qrData, // La donnée est maintenant unique
              version: QrVersions.auto,
              size: 200.0,
            ),
            const SizedBox(height: 20),
            Text(
              "N° Ticket : $ticketId",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              serviceName,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Text("Montant : $montant DT", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () =>
                  Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text("Retour à l'accueil"),
            ),
          ],
        ),
      ),
    );
  }
}
