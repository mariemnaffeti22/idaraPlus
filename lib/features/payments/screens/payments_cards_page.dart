import 'package:flutter/material.dart';
import '../models/card_type.dart';
import 'card_request_page.dart'; // N'oublie pas de créer ce fichier

class PaymentsCardsPage extends StatelessWidget {
  const PaymentsCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CardType> cards = [
      CardType(
        title: "e-Dinar Smart",
        description: "Idéale pour les achats en ligne",
        price: "10 DT",
        cardColor: Colors.blue.shade800,
      ),
      CardType(
        title: "Carte Internationale",
        description: "Pour vos voyages et paiements étrangers",
        price: "50 DT",
        cardColor: Colors.deepPurple,
      ),
      CardType(
        title: "Carte Jeune",
        description: "Pour les étudiants et jeunes actifs",
        price: "5 DT",
        cardColor: Colors.teal,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Paiements et Cartes")),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          // On passe le 'context' ici pour pouvoir naviguer
          return _buildCardItem(context, cards[index]);
        },
      ),
    );
  }

  // 1. Ajout de 'BuildContext context' en paramètre
  Widget _buildCardItem(BuildContext context, CardType card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: card.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            card.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(card.description, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Frais : ${card.price}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // 2. Navigation vers le formulaire de demande
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CardRequestPage(cardName: card.title),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text(
                  "Demander",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
