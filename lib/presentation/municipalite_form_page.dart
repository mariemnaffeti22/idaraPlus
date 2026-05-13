import 'package:flutter/material.dart';
import '../features/municipalities/screens/ticket_municipal_page.dart';

class MunicipaliteFormPage extends StatefulWidget {
  final String serviceType;
  const MunicipaliteFormPage({super.key, required this.serviceType});

  @override
  State<MunicipaliteFormPage> createState() => _MunicipaliteFormPageState();
}

class _MunicipaliteFormPageState extends State<MunicipaliteFormPage> {
  int _nombre = 1;
  String _docType = "Contrat";
  String _municipalite = "Tunis";

  // Calcul dynamique des frais
  double get _frais =>
      widget.serviceType == "Légalisation" ? _nombre * 0.500 : 1.000;

  // Liste des documents requis selon le service
  List<String> get _docsRequis => widget.serviceType == "Légalisation"
      ? ["CIN obligatoire", "Document original"]
      : ["CIN obligatoire", "Document à copier", "Original"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.serviceType)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // 1. Section Documents Requis
          const Text(
            "Documents nécessaires :",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          ..._docsRequis.map(
            (doc) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
                  const SizedBox(width: 8),
                  Text(doc),
                ],
              ),
            ),
          ),
          const Divider(height: 30),

          // 2. Formulaire Dynamique
          if (widget.serviceType == "Légalisation")
            _buildCounter("Nombre de feuilles"),

          if (widget.serviceType == "Copie conforme") ...[
            _buildDropdown("Type de document", [
              "Contrat",
              "Procuration",
              "Engagement",
              "Autre",
            ], (v) => setState(() => _docType = v!)),
            _buildCounter("Nombre de signatures"),
          ],

          _buildDropdown("Municipalité", [
            "Tunis",
            "Ariana",
            "Ben Arous",
          ], (v) => setState(() => _municipalite = v!)),

          const SizedBox(height: 20),
          Text(
            "Frais estimés : ${_frais.toStringAsFixed(3)} DT",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF003D5B),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: () => _confirmer(),
            child: const Text(
              "Confirmer",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounter(String label) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          value: _nombre.toDouble(),
          min: 1,
          max: 10,
          divisions: 9,
          label: "$_nombre",
          onChanged: (v) => setState(() => _nombre = v.toInt()),
        ),
      ],
    ),
  );

  Widget _buildDropdown(
    String label,
    List<String> items,
    Function(String?) onChanged,
  ) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items
          .map((i) => DropdownMenuItem(value: i, child: Text(i)))
          .toList(),
      onChanged: onChanged,
    ),
  );

  void _confirmer() {
    if (widget.serviceType == "Copie conforme") {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Vérification"),
          content: const Text(
            "Vérifiez que tous les signataires sont présents avec leurs CIN.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        TicketMunicipalPage(service: widget.serviceType),
                  ),
                );
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TicketMunicipalPage(service: widget.serviceType),
        ),
      );
    }
  }
}
