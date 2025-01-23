import 'package:flutter/material.dart';
import 'package:frontend/models/card.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/services/cards.dart';

class VCardsProvider extends ChangeNotifier {
  List<VCard> cards = [];

  Future<List<VCard>> getVCards() async {
    // print("getting cards");
    // print(cards[0].isExpired);
    if (true) {
      try {
        await AuthProvider().initAuth();
        cards = await DioClient().getVCards();
        // print(cards[0].name);
        // print(cards[0].expiryDate);
      } on Exception catch (_) {
        rethrow;
      }
      if (cards.isEmpty) throw("No Cards");
    }
    return cards;
  }

  Future<void> createVCard(VCard card) async {
    VCard newVCard = await DioClient().createVCard(card: card);
    cards.add(newVCard);
    notifyListeners();
  }

  Future<void> updateVCard(VCard card) async {
    VCard newVCard = await DioClient().updateVCard(card: card);
    int index = cards.indexWhere((card) => card.id == newVCard.id);
    cards[index] = newVCard;
    notifyListeners();
  }

  Future<void> deleteVCard(String cardId) async {
    await DioClient().deleteVCard(cardId: cardId);
    cards.removeWhere((card) => card.id == cardId);
    notifyListeners();
  }
}