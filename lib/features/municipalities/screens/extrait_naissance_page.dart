import 'package:flutter/material.dart';
import 'ticket_municipal_page.dart';

class ExtraitNaissancePage extends StatefulWidget {
  const ExtraitNaissancePage({super.key});

  @override
  State<ExtraitNaissancePage> createState() => _ExtraitNaissancePageState();
}

class _ExtraitNaissancePageState extends State<ExtraitNaissancePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cinController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();

  // Variable pour la date de naissance
  DateTime? _dateNaissance;

  String _modeRecuperation = "Retrait sur place";
  String _municipalite = "Tunis";

  // Date estimée : Demain
  String get _dateEstimee =>
      DateTime.now().add(const Duration(days: 2)).toString().split(' ')[0];

  // Fonction pour afficher le calendrier
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dateNaissance) {
      setState(() => _dateNaissance = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Extrait de naissance")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildTextField("CIN", _cinController),
            _buildTextField("Nom", _nomController),
            _buildTextField("Prénom", _prenomController),

            // --- Ajout du champ Date de naissance ---
            const SizedBox(height: 15),
            const Text(
              "Date de naissance",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  _dateNaissance == null
                      ? "Sélectionner une date"
                      : "${_dateNaissance!.day}/${_dateNaissance!.month}/${_dateNaissance!.year}",
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Municipalité de naissance",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: _municipalite,
              items: [
                "Tunis",
                "Ariana",
                "Ben Arous",
              ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (val) => setState(() => _municipalite = val!),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),

            const SizedBox(height: 20),
            const Text(
              "Mode de récupération",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RadioListTile(
              title: const Text("Retrait sur place"),
              value: "Retrait sur place",
              groupValue: _modeRecuperation,
              onChanged: (v) => setState(() => _modeRecuperation = v!),
            ),
            RadioListTile(
              title: const Text("Livraison"),
              value: "Livraison",
              groupValue: _modeRecuperation,
              onChanged: (v) => setState(() => _modeRecuperation = v!),
            ),

            Container(
              padding: const EdgeInsets.all(15),
              color: Colors.amber.shade50,
              child: Text(
                "Date de disponibilité estimée : $_dateEstimee",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003D5B),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                // Validation simple : vérifie si la date est choisie
                if (_formKey.currentState!.validate() &&
                    _dateNaissance != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TicketMunicipalPage(
                        service: "Extrait de naissance",
                      ),
                    ),
                  );
                } else if (_dateNaissance == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Veuillez choisir votre date de naissance"),
                    ),
                  );
                }
              },
              child: const Text(
                "Confirmer la demande",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (v) => v!.isEmpty ? "Obligatoire" : null,
      ),
    );
  }
}
