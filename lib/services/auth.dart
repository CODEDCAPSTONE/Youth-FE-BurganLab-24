import 'package:dio/dio.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/client.dart';

class AuthServices {

  Future<Map<String, dynamic>> signup({required User user}) async {
    try {
      Response response = await Client.dio.post('/auth/signup', data: user.toJson());
      return response.data;
    } on DioException catch (error) {
      print(error.response!.data);
      return {'errors': error.response!.data["errors"]};
    }
  }

  Future<Map<String, dynamic>> signin({required User user}) async {
    try {
      // print(user.toJson());
      Response response =
          await Client.dio.post('/auth/signin', data: user.toJson());
      return {'token': response.data["token"]};
      // print(token);
    } on DioException catch (error) {
      // print(error.response!);
      return {'errors': error.response!.data["errors"]};
    }
  }

  Future getBalance() async {
    try {
      // print(user.toJson());
      Response response =
          await Client.dio.get('/balance');
      return {'balance': response.data["balance"]};
      // print(token);
    } on DioException catch (error) {
      print(error.response!.data);
      return {'errors': error.response!.data["errors"]};
    }
  }

  Future getCards() async {
    try {
      // print(user.toJson());
      Response response =
          await Client.dio.get('/cards');
      return response.data;
      // print(token);
    } on DioException catch (error) {
      print(error.response!.data);
      return {'errors': error.response!.data["errors"]};
    }
  }

  Future getTransactions() async {
    try {
      // print(user.toJson());
      Response response =
          await Client.dio.get('/transactions');
      return response.data;
      // print(token);
    } on DioException catch (error) {
      print(error.response!.data);
      return {'errors': error.response!.data["errors"]};
    }
  }

  Future getIncome() async {
    try {
      // print(user.toJson());
      Response response =
          await Client.dio.get('/user/income');
      return response.data;
      // print(token);
    } on DioException catch (error) {
      print(error.response!.data);
      return {'errors': error.response!.data["errors"]};
    }
  }

  Future setIncome(int income) async {
    try {
      // print("Setting income");
      Response response =
          await Client.dio.post('/user/income', data: {"income": income});
      return response.data;
      // print(token);
    } on DioException catch (error) {
      print(error.response!.data);
      return {'errors': error.response!.data["errors"]};
    }
  }

  Future wamd(Map data) async {
    try {
      // print("Setting income");
      Response response =
          await Client.dio.post('/transfer/transferByWAMD', data: data);
      return response.data;
      // print(token);
    } on DioException catch (error) {
      print(error.response!.data);
      return {'errors': error.response!.data["errors"]};
    }
  }
}