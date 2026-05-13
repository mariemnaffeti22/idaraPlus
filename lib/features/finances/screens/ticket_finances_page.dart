import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class TicketFinancesPage extends StatefulWidget {
  final String service;
  const TicketFinancesPage({super.key, required this.service});

  @override
  State<TicketFinancesPage> createState() => _TicketFinancesPageState();
}

class _TicketFinancesPageState extends State<TicketFinancesPage> {
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> _shareTicket() async {
    final image = await _screenshotController.capture();
    if (image == null) return;
    final directory = await getTemporaryDirectory();
    final imagePath = await File(
      '${directory.path}/ticket_finances.png',
    ).create();
    await imagePath.writeAsBytes(image);
    await Share.shareXFiles([
      XFile(imagePath.path),
    ], text: 'Voici mon ticket des finances.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket Finances"),
        backgroundColor: const Color(0xFF003D5B),
      ),
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
                  border: Border.all(color: const Color(0xFF003D5B), width: 3),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "RECETTE DES FINANCES",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Divider(thickness: 2),
                    QrImageView(
                      data: "FIN-${DateTime.now().millisecondsSinceEpoch}",
                      size: 150,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      widget.service,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Guichet n°1 | Priorité: Standard",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
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
