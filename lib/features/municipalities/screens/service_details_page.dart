import 'package:flutter/material.dart';
import 'extrait_naissance_page.dart';
// Ajoute ceci en haut de ton fichier service_details_page.dart
import 'package:idara_plus/features/municipalities/screens/ticket_municipal_page.dart';

class ServiceDetailsPage extends StatelessWidget {
  final String serviceName;

  const ServiceDetailsPage({super.key, required this.serviceName});

  // Cette fonction renvoie la liste des documents selon le service
  List<String> _getDocuments() {
    switch (serviceName) {
      case "Comptes et Épargne":
        return [
          "Carte d'identité nationale (CIN)",
          "Justificatif de domicile",
          "Dépôt initial (50 DT)",
        ];
      case "Colis Postaux":
        return ["Numéro de suivi du colis", "Pièce d'identité originale"];
      case "Philatélie":
        return ["Carte d'adhérent (si disponible)", "Bon de commande"];
      case "Paiements et Cartes":
        return ["CIN", "Formulaire de demande", "Frais de dossier"];
      default:
        return ["Pièce d'identité", "Document justificatif"];
    }
  }

  @override
  Widget build(BuildContext context) {
    final documents = _getDocuments();

    return Scaffold(
      appBar: AppBar(
        title: Text(serviceName),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(
                "Si vous avez déjà tous ces documents, vous pouvez prendre un ticket pour aller à la poste pour le service : $serviceName.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Liste des documents dynamique
            Expanded(
              child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) =>
                    _buildDocItem(documents[index]),
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003D5B),
                ),
                onPressed: () {
                  if (serviceName == "Extrait de naissance") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExtraitNaissancePage(),
                      ),
                    );
                  } else {
                    // Ton comportement par défaut (vers le ticket directement)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const TicketMunicipalPage(service: "Service"),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Prendre un ticket",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocItem(String text) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.check_circle, color: Colors.green),
        title: Text(text),
      ),
    );
  }
}
