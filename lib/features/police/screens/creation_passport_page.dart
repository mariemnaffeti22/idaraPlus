import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:idara_plus/features/police/screens/recu_page.dart';

class CreationPassportPage extends StatefulWidget {
  const CreationPassportPage({super.key});

  @override
  State<CreationPassportPage> createState() => _CreationPassportPageState();
}

class _CreationPassportPageState extends State<CreationPassportPage> {
  int _currentStep = 0;
  bool _isSubmitted = false;
  String _type = "Normal";

  final Map<String, Map<String, dynamic>> _passportTypes = {
    "Normal": {"price": "80 DT", "delay": "15 jours"},
    "Urgent": {"price": "200 DT", "delay": "3 jours"},
    "Renouvellement": {"price": "80 DT", "delay": "10 jours"},
  };

  final List<String> _docs = [
    "Copie CIN",
    "Photo d'identité",
    "Timbre fiscal",
    "Ancien passeport",
  ];

  Future<void> _handleStepContinue() async {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      // Sauvegarde locale pour le suivi
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('passport_status', 0); // 0 = Envoyé
      await prefs.setString(
        'passport_date',
        DateFormat('dd/MM/yyyy').format(DateTime.now()),
      );

      setState(() => _isSubmitted = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSubmitted ? "Confirmation" : "Assistant Passeport"),
      ),
      body: _isSubmitted
          ? _buildSuccessView()
          : Stepper(
              currentStep: _currentStep,
              onStepContinue: _handleStepContinue,
              onStepCancel: () =>
                  _currentStep > 0 ? setState(() => _currentStep--) : null,
              steps: [
                Step(
                  title: const Text("Type & Frais"),
                  content: _buildTypeSelection(),
                  isActive: _currentStep >= 0,
                ),
                Step(
                  title: const Text("Documents"),
                  content: _buildDocChecklist(),
                  isActive: _currentStep >= 1,
                ),
                Step(
                  title: const Text("Validation"),
                  content: const Text(
                    "Veuillez confirmer l'envoi de votre demande de passeport.",
                  ),
                  isActive: _currentStep >= 2,
                ),
              ],
            ),
    );
  }

  Widget _buildTypeSelection() => Column(
    children: _passportTypes.keys
        .map(
          (type) => RadioListTile(
            title: Text(type),
            subtitle: Text(
              "${_passportTypes[type]!['price']} - Délai: ${_passportTypes[type]!['delay']}",
            ),
            value: type,
            groupValue: _type,
            onChanged: (val) => setState(() => _type = val!),
          ),
        )
        .toList(),
  );

  Widget _buildDocChecklist() => Column(
    children: _docs
        .map(
          (d) => CheckboxListTile(title: Text(d), value: true, onChanged: null),
        )
        .toList(),
  );

  Widget _buildSuccessView() => Center(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, size: 100, color: Colors.green),
          const SizedBox(height: 20),
          const Text(
            "Demande de passeport envoyée !",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecuPage(
                    titre: "Demande Passeport ($_type)",
                    date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                    poste: "Poste Central",
                  ),
                ),
              );
            },
            child: const Text("Voir mon reçu"),
          ),
        ],
      ),
    ),
  );
}
