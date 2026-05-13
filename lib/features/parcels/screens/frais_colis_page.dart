import 'package:flutter/material.dart';

class FraisColisPage extends StatefulWidget {
  const FraisColisPage({super.key});

  @override
  State<FraisColisPage> createState() => _FraisColisPageState();
}

class _FraisColisPageState extends State<FraisColisPage> {
  final TextEditingController _poidsController = TextEditingController();
  double _prixTotal = 0.0;
  final double _tarifParKg = 2.500; // Tarif de base par kg

  void _calculerPrix() {
    double poids = double.tryParse(_poidsController.text) ?? 0.0;
    setState(() {
      _prixTotal = poids * _tarifParKg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculateur de frais")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _poidsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Poids du colis (en kg)",
                border: OutlineInputBorder(),
                suffixText: "kg",
              ),
              onChanged: (value) => _calculerPrix(),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Prix estimé :",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${_prixTotal.toStringAsFixed(3)} DT",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 194, 95, 19),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
