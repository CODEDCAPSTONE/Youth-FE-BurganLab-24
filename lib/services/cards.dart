import 'package:dio/dio.dart';
import 'package:frontend/models/card.dart';
import 'package:frontend/models/transaction.dart';
import 'package:frontend/services/client.dart';

class DioClient {

  Future<List<VCard>> getVCards() async {
    List<VCard> cards = [];

    try {
      Response response = await Client.dio.get('/cards');
      // print((response.data as List));
      cards = (response.data as List).map((card) {
        // print(VCard.fromJson(card).name);
        return VCard.fromJson(card);
      }).toList();
      // print(cards[0].name);
    } on DioException catch (error) {
      print(error.type);
      if (error.response?.statusCode == 404 || error.type == DioExceptionType.connectionError) {
        throw("No Connection");
      }
      throw(error.response?.data['errors'][0]["message"]);
    }
    return cards;
  }

  Future<VCard> createVCard({required VCard card}) async {
    late VCard retrievedVCard;
    try {
      // print(data.fields);
      Response response = await Client.dio.post('/cards', data: {"name": card.name, "limit": card.limit});
      // print(response.data);
      retrievedVCard = VCard.fromJson(response.data);
    } on DioException catch (error) {
      print(error);
    }
    return retrievedVCard;
  }

  Future<VCard> updateVCard({required VCard card}) async {
    late VCard retrievedVCard;
    try {
      FormData data = FormData.fromMap({
        "name": card.name,
        // "amount": card.amount,
      });

      Response response =
          await Client.dio.put('/cards/${card.id}', data: data);
      retrievedVCard = VCard.fromJson(response.data);
    } on DioException catch (error) {
      print(error);
    }
    return retrievedVCard;
  }

  Future<void> deleteVCard({required String cardId}) async {
    try {
      await Client.dio.delete('/cards/$cardId');
    } on DioException catch (error) {
      print(error);
    }
  }

  Future<List<Transaction>> getTransactions(int cardNumber) async {
    List<Transaction> transactions = [];

    try {
      Response response = await Client.dio.get('/transaction/card', data: {"cardNumber": cardNumber});
      // print((response.data["list"] as List));
      transactions = (response.data["list"] as List).map((card) {
        // print(Transaction.fromJson(card).category);
        return Transaction.fromJson(card);
      }).toList();
      // print(cards[0].name);
    } on DioException catch (error) {
      print(error.type);
      if (error.response?.statusCode == 404 || error.type == DioExceptionType.connectionError) {
        throw("No Connection");
      }
      throw(error.response?.data['errors'][0]["message"]);
    }
    return transactions;
  }
}