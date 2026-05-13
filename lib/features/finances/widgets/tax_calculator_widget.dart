import 'package:flutter/material.dart';
// 1. IMPORTER LA PAGE DE TICKET
import 'package:idara_plus/features/finances/screens/ticket_finances_page.dart';

class TaxCalculatorWidget extends StatefulWidget {
  const TaxCalculatorWidget({super.key});

  @override
  State<TaxCalculatorWidget> createState() => _TaxCalculatorWidgetState();
}

class _TaxCalculatorWidgetState extends State<TaxCalculatorWidget> {
  final _controller = TextEditingController();
  double _result = 0.0;
  bool _showTicketOption = false;

  void _calculate() {
    setState(() {
      double amount = double.tryParse(_controller.text) ?? 0;
      _result = amount * 0.20;
      _showTicketOption = amount > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Montant (Salaire/Produit)",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(onPressed: _calculate, child: const Text("Calculer")),

          if (_result > 0) ...[
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            Text(
              "Taxe estimée : ${_result.toStringAsFixed(2)} DT",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              "Souhaitez-vous régulariser votre situation ?",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            // LE BOUTON QUI NAVIGUE VERS LE TICKET
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003D5B),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // 2. NAVIGATION VERS LA PAGE TICKET DÉDIÉE AUX FINANCES
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TicketFinancesPage(
                      service: "Impôts / Taxes calculées",
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.confirmation_number_outlined),
              label: const Text("Prendre un ticket"),
            ),
          ],
        ],
      ),
    );
  }
}
