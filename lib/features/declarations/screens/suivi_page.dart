import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuiviPage extends StatefulWidget {
  const SuiviPage({super.key});

  @override
  State<SuiviPage> createState() => _SuiviPageState();
}

class _SuiviPageState extends State<SuiviPage> {
  List<Map<String, dynamic>> _demandes = [];

  @override
  void initState() {
    super.initState();
    _loadDemandes();
  }

  Future<void> _loadDemandes() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> temp = [];

    // Liste de toutes les demandes possibles
    final types = [
      {'key': 'cin_status', 'titre': 'Creation CIN', 'date_key': 'cin_date'},
      {
        'key': 'passport_status',
        'titre': 'Creation Passeport',
        'date_key': 'passport_date',
      },
      {
        'key': 'vol_status',
        'titre': 'Déclaration de Vol',
        'date_key': 'vol_date',
      },
      {
        'key': 'perte_status',
        'titre': 'Déclaration de Perte',
        'date_key': 'perte_date',
      },
      {
        'key': 'bulletin_status',
        'titre': 'Bulletin n°3',
        'date_key': 'bulletin_date',
      },
    ];

    for (var item in types) {
      if (prefs.containsKey(item['key'] as String)) {
        temp.add({
          "key": item['key'],
          "titre": item['titre'],
          "status": prefs.getInt(item['key'] as String) ?? 0,
          "date": prefs.getString(item['date_key'] as String) ?? "13/05/2026",
        });
      }
    }

    setState(() => _demandes = temp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F9FB),
      appBar: AppBar(title: const Text("Suivi de mes dossiers")),
      body: _demandes.isEmpty
          ? const Center(child: Text("Aucune demande en cours."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _demandes.length,
              itemBuilder: (context, index) =>
                  _buildDemandeCard(_demandes[index]),
            ),
    );
  }

  Widget _buildDemandeCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['titre'],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text("Date: ${item['date']}"),
          const SizedBox(height: 15),
          _buildSmallTimeline(item['status']),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              int newStatus = (item['status'] + 1) % 3;
              await prefs.setInt(item['key'], newStatus);
              _loadDemandes();
            },
            child: const Text("Simuler changement statut"),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallTimeline(int currentStatus) {
    final steps = ["Envoyé", "Traitement", "Prêt"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(steps.length, (index) {
        bool isActive = index <= currentStatus;
        return Column(
          children: [
            Icon(
              isActive ? Icons.check_circle : Icons.circle_outlined,
              color: isActive ? Colors.blue : Colors.grey,
            ),
            Text(
              steps[index],
              style: TextStyle(
                fontSize: 10,
                color: isActive ? Colors.black : Colors.grey,
              ),
            ),
          ],
        );
      }),
    );
  }
}
