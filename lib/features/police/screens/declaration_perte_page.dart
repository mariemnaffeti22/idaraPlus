import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeclarationPertePage extends StatefulWidget {
  const DeclarationPertePage({super.key});

  @override
  State<DeclarationPertePage> createState() => _DeclarationPertePageState();
}

class _DeclarationPertePageState extends State<DeclarationPertePage> {
  int _currentStep = 0;
  bool _isSubmitted = false;

  // Champs du formulaire
  String _objetPerdu = "CIN";
  final TextEditingController _lieuController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _submitDeclaration() async {
    final prefs = await SharedPreferences.getInstance();
    // Sauvegarde pour le suivi (statut 0 = Reçu)
    await prefs.setInt('perte_status', 0);
    await prefs.setString('perte_objet', _objetPerdu);

    setState(() => _isSubmitted = true);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Déclaration de perte enregistrée !")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Déclaration de perte")),
      body: _isSubmitted
          ? _buildSuccessView()
          : Stepper(
              currentStep: _currentStep,
              onStepContinue: () => _currentStep < 2
                  ? setState(() => _currentStep++)
                  : _submitDeclaration(),
              onStepCancel: () =>
                  _currentStep > 0 ? setState(() => _currentStep--) : null,
              steps: [
                Step(
                  title: const Text("Détails"),
                  content: Column(
                    children: [
                      DropdownButtonFormField(
                        value: _objetPerdu,
                        items: ["CIN", "Passeport", "Permis", "Autre"]
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _objetPerdu = val as String),
                        decoration: const InputDecoration(
                          labelText: "Objet perdu",
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _lieuController,
                        decoration: const InputDecoration(
                          labelText: "Lieu présumé de la perte",
                        ),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                ),
                Step(
                  title: const Text("Description"),
                  content: TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: "Circonstances de la perte",
                    ),
                  ),
                  isActive: _currentStep >= 1,
                ),
                Step(
                  title: const Text("Confirmation"),
                  content: const Text(
                    "En confirmant, vous déclarez sur l'honneur la perte de cet objet.",
                  ),
                  isActive: _currentStep >= 2,
                ),
              ],
            ),
    );
  }

  Widget _buildSuccessView() => Center(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.description, size: 100, color: Colors.blue),
          const SizedBox(height: 20),
          const Text(
            "Déclaration enregistrée",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "La perte de votre $_objetPerdu a été enregistrée. Votre reçu numérique est disponible.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Retour à l'accueil"),
          ),
        ],
      ),
    ),
  );
}
