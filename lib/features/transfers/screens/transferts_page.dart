import 'package:flutter/material.dart';
import 'transfert_simulation_page.dart';

class TransfertsPage extends StatelessWidget {
  const TransfertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Liste des types de transferts
    final List<Map<String, String>> transferTypes = [
      {
        "title": "Mandat Minute",
        "subtitle": "Transfert instantané et sécurisé",
      },
      {"title": "Mandat National", "subtitle": "Transfert classique sous 24h"},
      {
        "title": "Transfert International",
        "subtitle": "Vers l'étranger en toute confiance",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transferts d'argent"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choisissez votre type de transfert :",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: transferTypes.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(15),
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFE1F5FE),
                        child: Icon(
                          Icons.currency_exchange,
                          color: Colors.blue,
                        ),
                      ),
                      title: Text(
                        transferTypes[index]["title"]!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(transferTypes[index]["subtitle"]!),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransfertSimulationPage(
                              serviceName: transferTypes[index]["title"]!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
