import 'package:flutter/material.dart';
// Importez toutes vos pages de fonctionnalités
import 'package:idara_plus/features/police/screens/creation_cin_page.dart';
import 'package:idara_plus/features/police/screens/creation_passport_page.dart';
import 'package:idara_plus/features/police/screens/declaration_vol_page.dart';
import 'package:idara_plus/features/police/screens/declaration_perte_page.dart';
import 'package:idara_plus/features/police/screens/bulletin_n3_page.dart';

class PostePolicePage extends StatelessWidget {
  const PostePolicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Poste\nde police",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 40),

              // Liste des services avec navigation
              _buildPoliceOption(
                "Creation CIN",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreationCinPage()),
                ),
              ),
              _buildPoliceOption(
                "Creation Passport",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreationPassportPage(),
                  ),
                ),
              ),
              _buildPoliceOption(
                "Declaration de vole",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DeclarationVolPage()),
                ),
              ),
              _buildPoliceOption(
                "Declaration de perte",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DeclarationPertePage(),
                  ),
                ),
              ),
              _buildPoliceOption(
                "Bulletin n°3",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BulletinN3Page()),
                ),
              ),

              const Spacer(),

              // Bloc Informations Pratiques
              _buildInfoPratiqueCard(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPoliceOption(String title, {VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.lightBlue.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget _buildInfoPratiqueCard() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF003D5B),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Informations Pratiques :",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Horaires : sont ouverts 24h/24.",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              SizedBox(height: 10),
              Text(
                "Contact :\nPolice Secours : 197 (Urgence national).\nGarde Nationale : 193 (Zones rurales).\nSOS Protection Civile : 198 (Accidents).",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF003D5B),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: const Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}
