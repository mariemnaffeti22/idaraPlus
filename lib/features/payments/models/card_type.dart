import 'package:flutter/material.dart'; 

class CardType {
  final String title;
  final String description;
  final String price;
  final Color cardColor; // Maintenant 'Color' sera reconnu

  CardType({
    required this.title,
    required this.description,
    required this.price,
    required this.cardColor,
  });
}
