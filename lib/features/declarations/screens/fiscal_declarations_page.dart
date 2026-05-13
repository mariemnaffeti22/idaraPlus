import 'package:flutter/material.dart';
import 'package:idara_plus/features/declarations/widgets/fiscal_calendar_widget.dart';
import 'declaration_details_page.dart';

class FiscalDeclarationsPage extends StatelessWidget {
  const FiscalDeclarationsPage({super.key});

  final List<Map<String, dynamic>> declarations = const [
    {
      "title": "Déclaration Annuelle",
      "icon": Icons.calendar_today,
      "color": Color(0xFF0091D5),
    },
    {"title": "TVA", "icon": Icons.percent, "color": Color(0xFF003D5B)},
    {"title": "Entreprise", "icon": Icons.business, "color": Color(0xFF6A1B9A)},
    {"title": "Particulier", "icon": Icons.person, "color": Color(0xFF2E7D32)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Déclarations Fiscales")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Mes Déclarations"),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: declarations.length,
              itemBuilder: (context, index) =>
                  _buildDeclarationCard(context, declarations[index]),
            ),
            _buildSectionTitle("Calendrier Fiscal"),
            const FiscalCalendarWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildDeclarationCard(
    BuildContext context,
    Map<String, dynamic> data,
  ) => GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DeclarationDetailsPage(title: data['title']),
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: data['color'],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(data['icon'], size: 40, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            data['title'],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildSectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}
