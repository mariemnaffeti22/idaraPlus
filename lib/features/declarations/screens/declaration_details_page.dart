import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:idara_plus/features/finances/screens/ticket_finances_page.dart';

class DeclarationDetailsPage extends StatefulWidget {
  final String title;
  const DeclarationDetailsPage({super.key, required this.title});

  @override
  State<DeclarationDetailsPage> createState() => _DeclarationDetailsPageState();
}

class _DeclarationDetailsPageState extends State<DeclarationDetailsPage> {
  // Liste des documents
  final Map<String, bool> _documents = {
    "CIN": false,
    "Factures": false,
    "Revenus": false,
    "Justificatifs": false,
  };

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  // Chargement de la progression en local
  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var key in _documents.keys) {
        _documents[key] = prefs.getBool("${widget.title}_$key") ?? false;
      }
    });
  }

  // Sauvegarde à chaque changement
  Future<void> _toggleDocument(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _documents[key] = value;
      prefs.setBool("${widget.title}_$key", value);
    });
  }

  bool get _isAllChecked => _documents.values.every((checked) => checked);

  @override
  Widget build(BuildContext context) {
    double progress =
        _documents.values.where((v) => v).length / _documents.length;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "${(progress * 100).toInt()}% complété",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  color: const Color(0xFF0091D5),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: _documents.keys
                  .map(
                    (doc) => CheckboxListTile(
                      title: Text(doc),
                      value: _documents[doc],
                      // Simulation du scan : cliquer sur la case coche la case
                      secondary: const Icon(
                        Icons.camera_alt,
                        color: Colors.grey,
                      ),
                      onChanged: (val) => _toggleDocument(doc, val!),
                    ),
                  )
                  .toList(),
            ),
          ),
          if (_isAllChecked)
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003D5B),
                  minimumSize: const Size(double.infinity, 55),
                ),
                icon: const Icon(Icons.confirmation_number),
                label: const Text("Prendre un ticket"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TicketFinancesPage(service: widget.title),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
