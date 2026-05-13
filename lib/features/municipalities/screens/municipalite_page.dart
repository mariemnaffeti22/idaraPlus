import 'package:flutter/material.dart';
import 'service_details_page.dart';
import 'extrait_naissance_page.dart';
import 'package:idara_plus/presentation/municipalite_form_page.dart'; // ← chemin correct

class MunicipalitePage extends StatelessWidget {
  const MunicipalitePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> services = [
      "Légalisation",
      "Copie conforme", // ← C majuscule
      "Extrait de naissance",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Municipalités")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return _buildMenuCard(context, services[index]);
              },
            ),
          ),
          _buildInfoBox(),
        ],
      ),
    );
  }

  

  Widget _buildMenuCard(BuildContext context, String title) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Utilisation d'un switch pour diriger vers la bonne page
          Widget destinationPage;

          // APRÈS
          switch (title) {
            case "Extrait de naissance":
              destinationPage = const ExtraitNaissancePage();
              break;
            case "Légalisation":
              destinationPage = MunicipaliteFormPage(
                serviceType: "Légalisation",
              );
              break;
            case "Copie conforme":
              destinationPage = MunicipaliteFormPage(
                serviceType: "Copie conforme",
              );
              break;
            default:
              destinationPage = ServiceDetailsPage(serviceName: title);
          }

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          );
        },
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF003D5B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        "Informations : Les services sont disponibles de 8h00 à 13h00.",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
