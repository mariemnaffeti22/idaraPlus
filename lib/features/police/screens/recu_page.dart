import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecuPage extends StatefulWidget {
  final String titre;
  final String date;
  final String poste;

  const RecuPage({
    super.key,
    required this.titre,
    required this.date,
    required this.poste,
  });

  @override
  State<RecuPage> createState() => _RecuPageState();
}

class _RecuPageState extends State<RecuPage> {
  String _nomUtilisateur = "Chargement...";

  @override
  void initState() {
    super.initState();
    _chargerNom();
  }

  Future<void> _chargerNom() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nomUtilisateur = prefs.getString('user_name') ?? "Citoyen";
    });
  }

  Future<void> _generateAndSharePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  "REÇU OFFICIEL IDARA PLUS",
                  style: pw.TextStyle(
                    fontSize: 25,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.Text(
                "Nom du titulaire : $_nomUtilisateur",
                style: const pw.TextStyle(fontSize: 18),
              ),
              pw.Text(
                "Objet de la demande : ${widget.titre}",
                style: const pw.TextStyle(fontSize: 18),
              ),
              pw.Text(
                "Date de la demande : ${widget.date}",
                style: const pw.TextStyle(fontSize: 18),
              ),
              pw.Text(
                "Poste de police : ${widget.poste}",
                style: const pw.TextStyle(fontSize: 18),
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File(
      "${output.path}/recu_${widget.titre.replaceAll(' ', '_')}.pdf",
    );
    await file.writeAsBytes(await pdf.save());

    // Partager le fichier
    await Share.shareXFiles([
      XFile(file.path),
    ], text: 'Voici votre reçu officiel Idara Plus.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Votre Reçu")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.receipt_long,
                size: 100,
                color: Color(0xFF003D5B),
              ),
              const SizedBox(height: 20),
              Text(
                "Reçu pour : ${widget.titre}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text("Titulaire : $_nomUtilisateur"),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  backgroundColor: const Color(0xFF0091D5),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.share),
                label: const Text("Partager / Télécharger PDF"),
                onPressed: _generateAndSharePDF,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Retour à l'accueil"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
