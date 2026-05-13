import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BulletinN3Page extends StatefulWidget {
  const BulletinN3Page({super.key});

  @override
  State<BulletinN3Page> createState() => _BulletinN3PageState();
}

class _BulletinN3PageState extends State<BulletinN3Page> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitted = false;

  // Contrôleurs
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  DateTime? _dateNaissance;

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _dateNaissance = picked);
    }
  }

  Future<void> _submitBulletin() async {
    if (_formKey.currentState!.validate() && _dateNaissance != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('bulletin_status', 0); // 0 = Reçu
      await prefs.setString(
        'bulletin_date',
        DateFormat('dd/MM/yyyy').format(DateTime.now()),
      );
      setState(() => _isSubmitted = true);
    } else if (_dateNaissance == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Veuillez sélectionner votre date de naissance"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bulletin n°3")),
      body: _isSubmitted
          ? _buildSuccessView()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Qu'est-ce que le Bulletin n°3 ?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Le bulletin n°3 contient les condamnations pénales. Il est souvent exigé pour le recrutement ou certains concours administratifs.",
                    ),
                    const SizedBox(height: 20),
                    const Divider(height: 40),

                    // --- FORMULAIRE COMPLET ---
                    const Text(
                      "Vos informations :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      controller: _nomController,
                      decoration: const InputDecoration(
                        labelText: "Nom",
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v!.isEmpty ? "Champ requis" : null,
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: _prenomController,
                      decoration: const InputDecoration(
                        labelText: "Prénom",
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v!.isEmpty ? "Champ requis" : null,
                    ),
                    const SizedBox(height: 10),

                    // Sélecteur de date
                    InkWell(
                      onTap: _pickDate,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: "Date de naissance",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(
                          _dateNaissance == null
                              ? "Sélectionner une date"
                              : DateFormat(
                                  'dd/MM/yyyy',
                                ).format(_dateNaissance!),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: _adresseController,
                      decoration: const InputDecoration(
                        labelText: "Adresse complète",
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v!.isEmpty ? "Champ requis" : null,
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submitBulletin,
                        child: const Text("Envoyer la demande"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSuccessView() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.picture_as_pdf, size: 100, color: Colors.blueAccent),
        const Text(
          "Demande envoyée !",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Retour"),
        ),
      ],
    ),
  );
}
