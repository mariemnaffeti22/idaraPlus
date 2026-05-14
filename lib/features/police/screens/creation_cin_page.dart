import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:idara_plus/features/police/screens/recu_page.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import nécessaire

class CreationCinPage extends StatefulWidget {
  const CreationCinPage({super.key});

  @override
  State<CreationCinPage> createState() => _CreationCinPageState();
}

class _CreationCinPageState extends State<CreationCinPage> {
  int _currentStep = 0;
  bool _isSubmitted = false;
  String _requestType = "Première demande";
  DateTime? _selectedDate;

  final Map<String, List<String>> _requirements = {
    "Première demande": [
      "Extrait de naissance",
      "4 Photos",
      "Certificat de résidence",
    ],
    "Renouvellement": ["Ancienne CIN", "4 Photos"],
    "CIN perdue": ["Déclaration de perte", "4 Photos", "Extrait de naissance"],
  };

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  // Ajout de la sauvegarde locale ici pour le suivi
  Future<void> _confirmRequest() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cin_status', 0); // 0 = Envoyé
    await prefs.setString(
      'cin_date',
      DateFormat('dd/MM/yyyy').format(DateTime.now()),
    );
    setState(() => _isSubmitted = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Assistant CIN")),
      body: _isSubmitted
          ? _buildSuccessView()
          : Stepper(
              currentStep: _currentStep,
              onStepContinue: () =>
                  _currentStep < 2 ? setState(() => _currentStep++) : null,
              onStepCancel: () =>
                  _currentStep > 0 ? setState(() => _currentStep--) : null,
              steps: [
                Step(
                  title: const Text("Type"),
                  content: _buildTypeSelection(),
                  isActive: _currentStep >= 0,
                ),
                Step(
                  title: const Text("Documents"),
                  content: _buildChecklist(),
                  isActive: _currentStep >= 1,
                ),
                Step(
                  title: const Text("Rendez-vous"),
                  content: _buildAppointmentPicker(),
                  isActive: _currentStep >= 2,
                ),
              ],
            ),
    );
  }

  Widget _buildSuccessView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 100),
          const SizedBox(height: 20),
          const Text(
            "Rendez-vous confirmé !",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecuPage(
                    // Le nom n'est plus passé ici car RecuPage le récupère seule
                    titre: "Demande CIN ($_requestType)",
                    date: _selectedDate != null
                        ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                        : "Non définie",
                    poste: "Poste Central",
                  ),
                ),
              );
            },
            child: const Text("Voir mon reçu"),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeSelection() => Column(
    children: _requirements.keys
        .map(
          (type) => RadioListTile(
            title: Text(type),
            value: type,
            groupValue: _requestType,
            onChanged: (val) => setState(() => _requestType = val!),
          ),
        )
        .toList(),
  );

  Widget _buildChecklist() => Column(
    children: _requirements[_requestType]!
        .map(
          (doc) =>
              CheckboxListTile(title: Text(doc), value: true, onChanged: null),
        )
        .toList(),
  );

  Widget _buildAppointmentPicker() => Column(
    children: [
      ListTile(
        title: Text(
          _selectedDate == null
              ? "Choisir une date"
              : DateFormat('dd/MM/yyyy').format(_selectedDate!),
        ),
        trailing: const Icon(Icons.calendar_month, color: Color(0xFF003D5B)),
        onTap: () => _pickDate(context),
      ),
      ElevatedButton(
        onPressed: _selectedDate == null
            ? null
            : () => _confirmRequest(), // Appel de la sauvegarde
        child: const Text("Confirmer le rendez-vous"),
      ),
    ],
  );
}
