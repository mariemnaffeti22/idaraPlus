import 'package:flutter/material.dart';

class ChatIAPage extends StatefulWidget {
  const ChatIAPage({super.key});

  @override
  State<ChatIAPage> createState() => _ChatIAPageState();
}

class _ChatIAPageState extends State<ChatIAPage> {
  int _selectedIndex = 3; // "Chat IA" is the 4th item

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
              // 1. Header
              _buildHeader(),

              // 2. Chat Area
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  children: [
                    const SizedBox(height: 10),
                    // User Message
                    _buildUserBubble(
                      "L'obtention de la Carte d'Identité\nNationale (CIN)",
                    ),

                    const SizedBox(height: 20),

                    // AI Response Card
                    _buildAIBubble(),

                    const SizedBox(height: 20),

                    // User Message (Short)
                    _buildUserBubble("Merci pour l'info"),
                  ],
                ),
              ),

              // 3. Bottom Input Field
              _buildChatInput(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- HEADER WIDGET ---
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F0FF), // Light purple/grey
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Color(0xFF003366),
              ),
            ),
          ),
          const Expanded(
            child: Text(
              "IdaraChat",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
            ),
          ),
          const SizedBox(width: 45), // Balance for the back button
        ],
      ),
    );
  }

  // --- USER CHAT BUBBLE ---
  Widget _buildUserBubble(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Color(0xFF0091D5), // Your brand blue
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            height: 1.3,
          ),
        ),
      ),
    );
  }

  // --- AI RESPONSE CARD ---
  Widget _buildAIBubble() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Étapes de la démarche",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
            ),
            const SizedBox(height: 15),
            _stepText(
              "1. ",
              "Collecte des pièces : ",
              "Récupérez d'abord votre certificat de nationalité au tribunal et votre extrait de naissance à la mairie.",
            ),
            _stepText(
              "2. ",
              "Dépôt du dossier : ",
              "Rendez-vous au poste de police ou de la garde nationale dont dépend votre lieu de résidence.",
            ),
            _stepText(
              "3. ",
              "Prise d'empreintes : ",
              "Vos empreintes digitales seront prises sur place au moment du dépôt.",
            ),
            _stepText(
              "4. ",
              "Retrait : ",
              "Un récépissé vous sera remis. Le délai d'obtention est généralement de 10 à 15 jours selon les régions.",
            ),
          ],
        ),
      ),
    );
  }

  // Helper for AI steps text
  Widget _stepText(String number, String boldText, String normalText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            height: 1.4,
          ),
          children: [
            TextSpan(text: number),
            TextSpan(
              text: boldText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: normalText),
          ],
        ),
      ),
    );
  }

  // --- INPUT FIELD ---
  Widget _buildChatInput() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F5F9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Type a message...",
            hintStyle: TextStyle(color: Colors.grey),
            suffixIcon: Icon(Icons.attachment, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  // --- BOTTOM NAV ---
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
          icon: Icon(Icons.chat_bubble),
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
