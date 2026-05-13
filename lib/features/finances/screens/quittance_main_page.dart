import 'package:flutter/material.dart';
import 'dart:math'; // Pour le côté aléatoire
import 'package:idara_plus/features/finances/screens/ticket_finances_page.dart';

class QuittanceMainPage extends StatefulWidget {
  const QuittanceMainPage({super.key});

  @override
  State<QuittanceMainPage> createState() => _QuittanceMainPageState();
}

class _QuittanceMainPageState extends State<QuittanceMainPage> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? _result;

  // Données aléatoires pour l'historique
  final List<Map<String, dynamic>> _history = [];

  @override
  void initState() {
    super.initState();
    _generateRandomHistory();
  }

  // Génère un historique aléatoire à chaque ouverture
  void _generateRandomHistory() {
    final random = Random();
    _history.clear();
    for (int i = 0; i < 3; i++) {
      _history.add({
        "type": ["Impôt Revenu", "Taxe Foncière", "TVA"][random.nextInt(3)],
        "date": "${random.nextInt(28) + 1}/05/2026",
        "montant": "${random.nextInt(500) + 50}.000 DT",
      });
    }
  }

  void _verifyQuittance() {
    final random = Random();
    setState(() {
      // Simulation : si texte > 5 chiffres = succès, sinon erreur
      if (_controller.text.length > 5) {
        _result = {
          "status": "valid",
          "date": "${random.nextInt(28) + 1}/05/2026",
          "montant": "${random.nextInt(500) + 50}.000 DT",
          "type": ["Impôt Revenu", "Taxe Foncière", "TVA"][random.nextInt(3)],
        };
      } else {
        _result = {"status": "invalid"};
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();
    // Message aléatoire pour les alertes
    final isLate = random.nextBool();

    return Scaffold(
      appBar: AppBar(title: const Text("Gestion des Quittances")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSearchSection(),
          const SizedBox(height: 20),
          if (_result != null) _buildResultCard(),

          // Alerte dynamique
          const Text(
            "Alertes importantes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _buildAlertCard(
            isLate ? "⚠️ Paiement en retard" : "✅ Tout est en ordre",
            isLate
                ? "Votre échéance a été dépassée."
                : "Aucune alerte pour le moment.",
            isLate ? Colors.orange : Colors.green,
          ),

          const SizedBox(height: 20),
          const Text(
            "Historique récent",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ..._history.map(
            (h) => ListTile(
              leading: const CircleAvatar(child: Icon(Icons.history)),
              title: Text(h['type']),
              subtitle: Text("Payé le ${h['date']}"),
              trailing: Text(
                h['montant'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() => Card(
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Numéro de quittance",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _verifyQuittance,
            child: const Text("Vérifier"),
          ),
        ],
      ),
    ),
  );

  Widget _buildResultCard() {
    bool isValid = _result!['status'] == 'valid';
    return Card(
      color: isValid ? Colors.green.shade50 : Colors.red.shade50,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Icon(
              isValid ? Icons.check_circle : Icons.cancel,
              color: isValid ? Colors.green : Colors.red,
              size: 50,
            ),
            Text(isValid ? "Paiement Validé" : "Quittance Introuvable"),
            if (isValid) ...[
              Text("Date : ${_result!['date']}"),
              Text("Montant : ${_result!['montant']}"),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.confirmation_number),
                label: const Text("Prendre un ticket"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TicketFinancesPage(
                      service: "Retrait: ${_result!['type']}",
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAlertCard(String title, String desc, Color color) => Card(
    color: color.withOpacity(0.1),
    child: ListTile(
      leading: Icon(Icons.warning, color: color),
      title: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(desc),
    ),
  );
}
