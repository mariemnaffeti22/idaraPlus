import 'package:flutter/material.dart';
import 'package:idara_plus/features/finances/screens/imposable_page.dart';
import 'package:idara_plus/features/declarations/screens/fiscal_declarations_page.dart';
// 1. AJOUT DE L'IMPORT DE LA PAGE QUITTANCE
import 'package:idara_plus/features/finances/screens/quittance_main_page.dart'; 

class RecetteFinancesPage extends StatelessWidget {
  const RecetteFinancesPage({super.key});

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
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children:[
              const SizedBox(height: 20),
              const Text(
                "Recette\ndes finances",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 50),

              // Liste des services
              _buildServiceOption(
                "Impôts directs et indirects",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ImposDirectsIndirectsPage(),
                    ),
                  );
                },
              ),

              _buildServiceOption(
                "Déclarations fiscales",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FiscalDeclarationsPage(),
                    ),
                  );
                },
              ),

              // 2. NAVIGATION AJOUTÉE POUR LA QUITTANCE
              _buildServiceOption(
                "La quittance d'impôt",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuittanceMainPage(),
                    ),
                  );
                },
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

  Widget _buildServiceOption(String title, {VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF0091D5).withOpacity(0.3)),
        boxShadow:[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Color(0xFF0091D5),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildInfoPratiqueCard() {
    return Stack(
      clipBehavior: Clip.none,
      children:[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF003D5B),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(
                "Informations Pratiques :",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Horaires : Les bureaux fonctionnent généralement en séance double l'hiver et en séance unique l'été (7h30 - 13h00)",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Contact : Le centre d'appel est joignable au 1828",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: -10,
          bottom: -10,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF003D5B),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}