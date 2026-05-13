import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeclarationVolPage extends StatefulWidget {
  const DeclarationVolPage({super.key});

  @override
  State<DeclarationVolPage> createState() => _DeclarationVolPageState();
}

class _DeclarationVolPageState extends State<DeclarationVolPage> {
  int _currentStep = 0;
  bool _isSubmitted = false;

  // Champs du formulaire
  String _objetVole = "CIN";
  DateTime _dateVol = DateTime.now();
  final TextEditingController _lieuController = TextEditingController();

  Future<void> _submitDeclaration() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('vol_status', 0); // 0 = Reçu
    await prefs.setString('vol_objet', _objetVole);
    setState(() => _isSubmitted = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Déclaration de Vol")),
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
                        value: _objetVole,
                        items: ["CIN", "Passeport", "Permis", "Autre"]
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _objetVole = val as String),
                        decoration: const InputDecoration(
                          labelText: "Objet volé",
                        ),
                      ),
                      TextFormField(
                        controller: _lieuController,
                        decoration: const InputDecoration(
                          labelText: "Lieu du vol",
                        ),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                ),
                Step(
                  title: const Text("Preuves"),
                  content: const ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Ajouter une photo / vidéo"),
                    subtitle: Text("Uploadez des preuves du vol"),
                  ),
                  isActive: _currentStep >= 1,
                ),
                Step(
                  title: const Text("Confirmation"),
                  content: const Text(
                    "Vous êtes sur le point de déclarer ce vol officiellement.",
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
          const Icon(Icons.report_problem, size: 100, color: Colors.orange),
          const SizedBox(height: 20),
          const Text(
            "Déclaration reçue",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "Vol de $_objetVole enregistré. Votre dossier est en cours d'investigation.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Retour"),
          ),
        ],
      ),
    ),
  );
}
