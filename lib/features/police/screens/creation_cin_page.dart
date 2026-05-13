import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Utile pour formater la date

class CreationCinPage extends StatefulWidget {
  const CreationCinPage({super.key});

  @override
  State<CreationCinPage> createState() => _CreationCinPageState();
}

class _CreationCinPageState extends State<CreationCinPage> {
  int _currentStep = 0;
  String _requestType = "Première demande";
  DateTime? _selectedDate;

  // Simulation de l'état du dossier (pour la timeline)
  // 0: Envoyé, 1: Traitement, 2: Prêt
  final int _currentStatus = 1;

  final Map<String, List<String>> _requirements = {
    "Première demande": [
      "Extrait de naissance",
      "4 Photos",
      "Certificat de résidence",
    ],
    "Renouvellement": ["Ancienne CIN", "4 Photos"],
    "CIN perdue": ["Déclaration de perte", "4 Photos", "Extrait de naissance"],
  };

  // --- LOGIQUE SÉLECTEUR DE DATE ---
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Assistant CIN")),
      body: Column(
        children: [
          // TIMELINE DE SUIVI (Affichée en haut)
          _buildTimeline(),

          Expanded(
            child: Stepper(
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
          ),
        ],
      ),
    );
  }

  // --- TIMELINE VISUELLE (Suivi de dossier) ---
  Widget _buildTimeline() {
    final steps = ["Envoyé", "Traitement", "Prêt"];
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          steps.length,
          (index) => Column(
            children: [
              Icon(
                index <= _currentStatus
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                color: index <= _currentStatus ? Colors.green : Colors.grey,
              ),
              Text(
                steps[index],
                style: TextStyle(
                  fontSize: 12,
                  color: index <= _currentStatus ? Colors.green : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeSelection() {
    return Column(
      children: ["Première demande", "Renouvellement", "CIN perdue"]
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
  }

  Widget _buildChecklist() {
    return Column(
      children: _requirements[_requestType]!
          .map(
            (doc) => CheckboxListTile(
              title: Text(doc),
              value: true,
              onChanged: (val) {},
            ),
          )
          .toList(),
    );
  }

  Widget _buildAppointmentPicker() {
    return Column(
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
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _selectedDate == null
              ? null
              : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Rendez-vous confirmé !")),
                  );
                },
          child: const Text("Confirmer le rendez-vous"),
        ),
      ],
    );
  }
}
