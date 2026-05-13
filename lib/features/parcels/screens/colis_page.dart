import 'package:flutter/material.dart';
import 'frais_colis_page.dart';
import 'package:idara_plus/features/parcels/ticket_page.dart';

class ColisPage extends StatefulWidget {
  const ColisPage({super.key});

  @override
  State<ColisPage> createState() => _ColisPageState();
}

class _ColisPageState extends State<ColisPage> {
  final TextEditingController _trackingController = TextEditingController();
  String _status = "";
  bool _isLoading = false;

  void _trackParcel() {
    setState(() {
      if (_trackingController.text.isNotEmpty) {
        _status =
            "Votre colis ${_trackingController.text} est actuellement au centre de tri.";
      } else {
        _status = "Veuillez entrer un numéro de suivi valide.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Colis Postaux")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _trackingController,
              decoration: InputDecoration(
                labelText: "Entrez votre numéro de suivi",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _trackParcel,
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (_status.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue),
                ),
                child: Text(_status, style: const TextStyle(fontSize: 16)),
              ),
            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003D5B),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: _isLoading
                    ? null
                    : () async {
                        setState(() => _isLoading = true);

                        // Attente simulée
                        await Future.delayed(
                          const Duration(milliseconds: 1500),
                        );

                        // Sécurité : Vérifie si le widget est toujours dans l'arbre avant de continuer
                        if (!context.mounted) return;

                        setState(() => _isLoading = false);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const TicketPage(serviceType: "Envoi Colis"),
                          ),
                        );
                      },
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.confirmation_number, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            "Prendre ticket : Envoi colis",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 10),

            ListTile(
              leading: const Icon(Icons.calculate, color: Colors.blueAccent),
              title: const Text("Calculer frais d'envoi"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FraisColisPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
