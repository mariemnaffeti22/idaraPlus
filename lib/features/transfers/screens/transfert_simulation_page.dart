import 'package:flutter/material.dart';
import 'ticket_result_page.dart';

class TransfertSimulationPage extends StatefulWidget {
  final String serviceName;
  const TransfertSimulationPage({super.key, required this.serviceName});

  @override
  State<TransfertSimulationPage> createState() =>
      _TransfertSimulationPageState();
}

class _TransfertSimulationPageState extends State<TransfertSimulationPage> {
  final TextEditingController _amountController = TextEditingController();
  double _frais = 0.0;

  void _calculerFrais() {
    double montant = double.tryParse(_amountController.text) ?? 0.0;
    setState(() {
      // Simulation : 5% de frais
      _frais = montant * 0.05;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.serviceName)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Montant à transférer (DT)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
              onChanged: (value) => _calculerFrais(),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Frais estimés :", style: TextStyle(fontSize: 18)),
                  Text(
                    "${_frais.toStringAsFixed(2)} DT",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003D5B),
                ),
                onPressed: () {
                  // 1. On récupère la valeur et on tente de la convertir en nombre
                  final montantText = _amountController.text;
                  final double? montant = double.tryParse(montantText);

                  // 2. Vérification : le champ n'est pas vide ET le montant est supérieur à 0
                  if (montantText.isNotEmpty &&
                      montant != null &&
                      montant > 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TicketResultPage(
                          serviceName: widget.serviceName,
                          montant: montant.toStringAsFixed(
                            2,
                          ), // Formate proprement à 2 décimales
                        ),
                      ),
                    );
                  } else {
                    // 3. Message d'erreur plus précis
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Veuillez entrer un montant valide supérieur à 0",
                        ),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },

                child: const Text(
                  "Valider et prendre un ticket",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
