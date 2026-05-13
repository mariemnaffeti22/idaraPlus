import 'package:flutter/material.dart';
import '../features/municipalities/screens/service_details_page.dart';
import '../features/transfers/screens/transferts_page.dart';
import '../features/payments/screens/payments_cards_page.dart';
// Vérifie que tu n'as qu'une seule ligne pour ColisPage ici
import '../features/parcels/screens/colis_page.dart';
import '../features/philately/screens/philatelie_page.dart';

class PostePage extends StatefulWidget {
  const PostePage({super.key});

  @override
  State<PostePage> createState() => _PostePageState();
}

class _PostePageState extends State<PostePage> {
  int _selectedIndex = 2;

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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(
                        "Poste",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      _buildMenuCard("Comptes et Épargne"),
                      _buildMenuCard("Transferts d'argent"),
                      _buildMenuCard("Paiements et Cartes"),
                      _buildMenuCard("Colis Postaux"),
                      _buildMenuCard("Philatélie"),
                      const SizedBox(height: 30),
                      _buildInfoBox(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildMenuCard(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlue.withValues(alpha: 0.15), // CORRIGÉ ICI
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Widget destinationPage;
            switch (title) {
              case "Philatélie":
                destinationPage = const PhilateliePage();
                break;
              case "Colis Postaux":
                destinationPage = const ColisPage();
                break;
              case "Transferts d'argent":
                destinationPage = const TransfertsPage();
                break;
              case "Paiements et Cartes":
                destinationPage = const PaymentsCardsPage();
                break;
              default:
                destinationPage = ServiceDetailsPage(
                  serviceName: title,
                ); // PAS DE CONST ICI
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destinationPage),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF003D5B),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Informations Pratiques :",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Horaires : Les bureaux fonctionnent généralement en séance double l'hiver et en séance unique l'été (7h30 - 13h00)",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Contact : Le centre d'appel est joignable au 1828",
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
        ),
        const Positioned(
          bottom: -15,
          right: -10,
          child: CircleAvatar(
            backgroundColor: Color(0xFF003D5B),
            radius: 24,
            child: Icon(Icons.priority_high, color: Colors.white, size: 28),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      onTap: (i) => setState(() => _selectedIndex = i),
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
    );
  }
}
