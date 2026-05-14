import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:idara_plus/features/police/screens/recu_page.dart'; // ← même import que CreationCinPage

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

  // Date de soumission (pour le reçu)
  DateTime? _submittedAt;

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _adresseController.dispose();
    super.dispose();
  }

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
      setState(() {
        _submittedAt = DateTime.now();
        _isSubmitted = true;
      });
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
      body: _isSubmitted ? _buildSuccessView() : _buildForm(),
    );
  }

  // ─── Vue succès (même structure que CreationCinPage) ───────────────────────
  Widget _buildSuccessView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 100),
          const SizedBox(height: 20),
          const Text(
            "Demande envoyée !",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecuPage(
                    titre: "Demande Bulletin n°3",
                    date: _submittedAt != null
                        ? DateFormat('dd/MM/yyyy').format(_submittedAt!)
                        : "Non définie",
                    poste: "Tribunal / Service compétent",
                    // Si RecuPage accepte d'autres champs optionnels,
                    // vous pouvez les ajouter ici (ex: nom, prénom…)
                  ),
                ),
              );
            },
            child: const Text("Voir mon reçu"),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Retour"),
          ),
        ],
      ),
    );
  }

  // ─── Formulaire ────────────────────────────────────────────────────────────
  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Explication ──
            const Text(
              "Qu'est-ce que le Bulletin n°3 ?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Le bulletin n°3 contient les condamnations pénales. "
              "Il est souvent exigé pour le recrutement ou certains concours administratifs.",
            ),
            const SizedBox(height: 20),
            const Divider(height: 40),

            // ── Formulaire ──
            const Text(
              "Vos informations :",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 15),

            TextFormField(
              controller: _nomController,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: "Nom",
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? "Champ requis" : null,
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: _prenomController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: "Prénom",
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? "Champ requis" : null,
            ),
            const SizedBox(height: 10),

            // ── Sélecteur de date de naissance ──
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
                      : DateFormat('dd/MM/yyyy').format(_dateNaissance!),
                  style: TextStyle(
                    color: _dateNaissance == null
                        ? Colors.grey.shade600
                        : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            TextFormField(
              controller: _adresseController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: "Adresse complète",
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? "Champ requis" : null,
            ),
            const SizedBox(height: 24),

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
    );
  }
}
