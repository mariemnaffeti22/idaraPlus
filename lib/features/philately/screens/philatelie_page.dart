import 'package:flutter/material.dart';
import 'package:idara_plus/features/parcels/ticket_page.dart'; // Import correct vers le ticket

class PhilateliePage extends StatelessWidget {
  const PhilateliePage({super.key});

  final List<Map<String, String>> timbres = const [
    {"nom": "Timbre 500 millimes", "prix": "0.500 DT"},
    {"nom": "Timbre 1 DT", "prix": "1.000 DT"},
    {"nom": "Série Collection", "prix": "5.000 DT"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Philatélie")),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: timbres.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.local_post_office,
                        size: 50,
                        color: Colors.brown,
                      ),
                      Text(timbres[index]["nom"]!),
                      Text(
                        timbres[index]["prix"]!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () =>
                            _reserver(context, timbres[index]["nom"]!),
                        child: const Text("Réserver"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003D5B),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const TicketPage(serviceType: "Achat Timbres"),
                  ),
                );
              },
              child: const Text(
                "Prendre ticket pour achat guichet",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _reserver(BuildContext context, String nom) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Réservation de : $nom effectuée !")),
    );
  }
}
