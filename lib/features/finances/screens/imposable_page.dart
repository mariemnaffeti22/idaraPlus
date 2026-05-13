import 'package:flutter/material.dart';
// Assurez-vous que ce chemin correspond à votre structure de dossiers
import '../widgets/tax_calculator_widget.dart';

class ImposDirectsIndirectsPage extends StatelessWidget {
  const ImposDirectsIndirectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Impôts & Taxes"),
        backgroundColor: const Color(0xFF003D5B), // Bleu foncé de votre thème
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Comprendre les impôts"),
            _buildExplicationCard(
              "Impôts Directs",
              "Payés directement par le contribuable (ex: Impôt sur le revenu).",
              Icons.person_outline,
            ),
            _buildExplicationCard(
              "Impôts Indirects",
              "Payés lors de la consommation (ex: TVA).",
              Icons.shopping_cart_outlined,
            ),
            _buildSectionTitle("Exemples interactifs"),
            _buildTaxGrid(context),
            _buildSectionTitle("Simulateur rapide"),
            const TaxCalculatorWidget(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );

  Widget _buildExplicationCard(String title, String desc, IconData icon) =>
      Card(
        margin: const EdgeInsets.only(bottom: 15),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(icon, color: const Color(0xFF0091D5), size: 30),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(desc),
        ),
      );

  Widget _buildTaxGrid(BuildContext context) {
    final taxes = [
      {"name": "Impôt sur le revenu", "type": "Direct"},
      {"name": "TVA", "type": "Indirect"},
      {"name": "Taxe Foncière", "type": "Direct"},
      {"name": "Taxe sur produits", "type": "Indirect"},
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: taxes
          .map(
            (t) => ActionChip(
              label: Text(t['name']!),
              backgroundColor: const Color(0xFFE1F5FE),
              onPressed: () => _showTaxDetail(context, t),
            ),
          )
          .toList(),
    );
  }

  void _showTaxDetail(BuildContext context, Map<String, String> tax) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tax['name']!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF0091D5).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Type : ${tax['type']}",
                style: const TextStyle(
                  color: Color(0xFF0091D5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Détails : Ce montant est prélevé par les autorités fiscales pour contribuer au budget de l'État. Il est calculé selon les barèmes en vigueur.",
              style: TextStyle(fontSize: 15, height: 1.5),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Fermer"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
