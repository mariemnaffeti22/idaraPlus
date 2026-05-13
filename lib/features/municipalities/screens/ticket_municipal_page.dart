import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class TicketMunicipalPage extends StatefulWidget {
  final String service;
  const TicketMunicipalPage({super.key, required this.service});

  @override
  State<TicketMunicipalPage> createState() => _TicketMunicipalPageState();
}

class _TicketMunicipalPageState extends State<TicketMunicipalPage> {
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> _shareTicket() async {
    final image = await _screenshotController.capture();
    if (image == null) return;
    final directory = await getTemporaryDirectory();
    final imagePath = await File('${directory.path}/ticket_muni.png').create();
    await imagePath.writeAsBytes(image);
    await Share.shareXFiles([
      XFile(imagePath.path),
    ], text: 'Voici mon ticket municipal.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ticket Municipal")),
      body: Column(
        children: [
          Expanded(
            child: Screenshot(
              controller: _screenshotController,
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.shade900, width: 2),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "MUNICIPALITÉ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Divider(thickness: 2),
                    QrImageView(data: "MUNI-REF-001", size: 150),
                    const SizedBox(height: 15),
                    Text(
                      widget.service,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Guichet n°4 | Attente estimée: 15 min",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bouton Aperçu PDF (Simulation)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text("Visualiser l'aperçu PDF"),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Ouverture du document simulée..."),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton.icon(
              onPressed: _shareTicket,
              icon: const Icon(Icons.share),
              label: const Text("Partager le ticket"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF003D5B),
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
