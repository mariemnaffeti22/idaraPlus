import 'package:flutter/material.dart';
import 'poste_page.dart';

class AdministrationPage extends StatefulWidget {
  const AdministrationPage({super.key});

  @override
  State<AdministrationPage> createState() => _AdministrationPageState();
}

class _AdministrationPageState extends State<AdministrationPage> {
  int _selectedIndex = 2; // "Accueil" is the 3rd item (index 2)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient Background
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

              // The Grid of Cards
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.82, // Adjust card height/width ratio
                    children: [
                      _buildAdminCard(
                        title: "Municipalities",
                        image: 'assets/messages.png', // input_file_9
                        isBlue: true,
                      ),
                      _buildAdminCard(
                        title: "Poste",
                        image: 'assets/mailbox.png',
                        isBlue: false,
                        onTap: () {
                          // This will work now!
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
                        image: 'assets/Wallet.png', // input_file_7
                        isBlue: false,
                      ),
                      _buildAdminCard(
                        title: "Poste\nde police",
                        image: 'assets/handshake.png', // input_file_6
                        isBlue: false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.layers_outlined),
            label: "Démarches",
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.account_balance_outlined),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 8,
                      minHeight: 8,
                    ),
                  ),
                ),
              ],
            ),
            label: "Suivi",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Accueil",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "Chat IA",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profil",
          ),
        ],
      ),
    );
  }

  // Helper widget to build the individual cards
  // Update your helper function to look like this:
  Widget _buildAdminCard({
    required String title,
    required String image,
    required bool isBlue,
    VoidCallback? onTap, // 1. Add this line
  }) {
    return GestureDetector(
      // 2. Wrap everything in a GestureDetector
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isBlue ? const Color(0xFF0091D5) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
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
