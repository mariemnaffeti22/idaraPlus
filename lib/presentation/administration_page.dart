import 'package:flutter/material.dart';
import 'package:idara_plus/presentation/chat_ia_page.dart';
import 'package:idara_plus/presentation/municipalite_form_page.dart'
    show MunicipaliteFormPage;
import 'package:idara_plus/features/municipalities/screens/extrait_naissance_page.dart';
import 'poste_page.dart';
import 'package:idara_plus/features/finances/screens/recette_finances_page.dart';
import 'package:idara_plus/features/police/screens/poste_police_page.dart';
// AJOUT DE L'IMPORT POUR LA PAGE SUIVI
import 'package:idara_plus/features/declarations/screens/suivi_page.dart';

class AdministrationPage extends StatefulWidget {
  const AdministrationPage({super.key});

  @override
  State<AdministrationPage> createState() => _AdministrationPageState();
}

class _AdministrationPageState extends State<AdministrationPage> {
  int _selectedIndex = 2; // Index de "Accueil"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF1F9FB), Colors.white, Color(0xFFD1EEF8)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                "Choisir votre\nadministration",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.82,
                    children: [
                      _buildAdminCard(
                        title: "Municipalities",
                        image: 'assets/messages.png',
                        isBlue: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MunicipalitePage(),
                            ),
                          );
                        },
                      ),
                      _buildAdminCard(
                        title: "Poste",
                        image: 'assets/mailbox.png',
                        isBlue: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PostePage(),
                            ),
                          );
                        },
                      ),
                      _buildAdminCard(
                        title: "Recette\ndes finances",
                        image: 'assets/Wallet.png',
                        isBlue: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RecetteFinancesPage(),
                            ),
                          );
                        },
                      ),
                      _buildAdminCard(
                        title: "Poste\nde police",
                        image: 'assets/handshake.png',
                        isBlue: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PostePolicePage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        // LOGIQUE DE NAVIGATION CORRIGÉE
        onTap: (index) {
  if (index == 1) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuiviPage()),
    );
  } else if (index == 3) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChatIAPage()),
    );
  } else {
    setState(() => _selectedIndex = index);
  }
},
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.layers_outlined),
            label: "Démarches",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_outlined),
            label: "Suivi",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "Chat IA",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profil",
          ),
        ],
      ),
    );
  }

  Widget _buildAdminCard({
    required String title,
    required String image,
    required bool isBlue,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isBlue ? const Color(0xFF0091D5) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isBlue ? Colors.white : const Color(0xFF0091D5),
                ),
              ),
            ),
            const Spacer(),
            Center(child: Image.asset(image, height: 100, fit: BoxFit.contain)),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

// Classe MunicipalitePage inchangée...
class MunicipalitePage extends StatelessWidget {
  const MunicipalitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Municipalité"),
        backgroundColor: const Color(0xFF003D5B),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Choisissez votre service :",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            _buildServiceButton(
              context,
              label: "Légalisation",
              icon: Icons.verified_outlined,
            ),
            const SizedBox(height: 16),
            _buildServiceButton(
              context,
              label: "Copie conforme",
              icon: Icons.content_copy_outlined,
            ),
            const SizedBox(height: 16),
            _buildServiceButton(
              context,
              label: "Extrait de naissance",
              icon: Icons.description_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceButton(
    BuildContext context, {
    required String label,
    required IconData icon,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0091D5),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(icon, size: 24),
      label: Text(label, style: const TextStyle(fontSize: 17)),
      onPressed: () {
        if (label == "Extrait de naissance") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ExtraitNaissancePage()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MunicipaliteFormPage(serviceType: label),
            ),
          );
        }
      },
    );
  }
}
