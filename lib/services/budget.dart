import 'package:dio/dio.dart';
import 'package:frontend/services/client.dart';

class BudgetServices {

  Future getBudget() async {
    try {
      Response response = await Client.dio.get('/budget');
      print(response.data);
      return response.data;

    } on DioException catch (_) {
      rethrow;
    }
  }

  Future setBudget(Map<String, int> request) async {
    try {
      // print(request);
      Response response = await Client.dio.post('/budget/create', data: request);
      return response.data;

    } on DioException catch (_) {
      rethrow;
    }
  }

  Future editBudget(Map<String, int> request) async {
    try {
      // print(request);
      Response response = await Client.dio.put('/budget/edit', data: request);
      return response.data;

    } on DioException catch (_) {
      rethrow;
    }
  }

  // Future<Target> createTarget(Target target) async {
  //   late Target retrievedTarget;
  //   try {
  //     var data = {
  //       "targetName": target.targetName,
  //       "balanceTarget": target.balanceTarget,
  //       "totalAmount": target.totalAmount,
  //       "duration": target.duration,
  //       "income": int.parse(target.income),
  //       // "amount": card.amount,
  //     };
  //     // print(data.fields);
  //     Response response = await Client.dio.post('/targets', data: data);
  //     // print(response.data);
  //     retrievedTarget = Target.fromJson(response.data);
  //   } on DioException catch (error) {
  //     print(error);
  //   }
  //   return retrievedTarget; 
  // }

}