import 'package:dio/dio.dart';
import 'package:frontend/models/card.dart';
import 'package:frontend/models/transaction.dart';
import 'package:frontend/services/client.dart';

class DioClient {

  Future<List<VCard>> getVCards() async {
    List<VCard> cards = [];

    try {
      Response response = await Client.dio.get('/cards');
      // print('getting cards ${response.data}');
      // print((response.data as List).length);
      cards = (response.data as List).map((card) {
        print(card);
        // print(VCard.fromJson(card).balance);
        return VCard.fromJson(card);
      }).toList();
      print('card length:');
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
      print(card.name);
      Response response = await Client.dio.post('/cards', data: {"name": card.name});
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

  Future<List<Transaction>> getTransactions(VCard card) async {
    List<Transaction> transactions = [];

    try {
      Response response = await Client.dio.get('/cards/transaction/${card.id}');
      // print((response.data as List));
      transactions = (response.data as List).map((card) {
        // print(card);
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

  Future<void> updateStatus() async {
    try {
      await Client.dio.post('/cards/student');
    } on DioException catch (error) {
      print(error);
    }
  }
}