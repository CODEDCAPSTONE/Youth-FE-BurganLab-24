import 'package:dio/dio.dart';
import 'package:frontend/models/target.dart';
import 'package:frontend/services/client.dart';

class TargetServices {

  Future getTargets() async {
    // print("getting Targets");
    List<Target> targets;
    try {
      Response response = await Client.dio.get('/targets');
      // print(response);
      targets = (response.data["targets"] as List).map((target) {
        return Target.fromJson(target);
      }).toList();
      // print(targets);

    } on DioException catch (_) {
      rethrow;
    }
    return targets;
  }

  Future<Target> createTarget(Target target) async {
    late Target retrievedTarget;
    try {
      var data = {
        "targetName": target.targetName,
        "balanceTarget": target.balanceTarget,
        "totalAmount": target.totalAmount,
        "duration": target.duration,
        // "income": int.parse(target.income),
        // "amount": card.amount,
      };
      // print(data.fields);
      Response response = await Client.dio.post('/targets', data: data);
      // print(response.data);
      retrievedTarget = Target.fromJson(response.data);
    } on DioException catch (error) {
      print(error);
    }
    return retrievedTarget; 
  }

  Future deleteTarget(String targetId) async {
    // late Target retrievedTarget;
    try {
      // var data = {
      //   "targetName": target.targetName,
      //   "balanceTarget": target.balanceTarget,
      //   "totalAmount": target.totalAmount,
      //   "duration": target.duration,
      //   // "income": int.parse(target.income),
      //   // "amount": card.amount,
      // };
      // print(data.fields);
      Response response = await Client.dio.post('/targets/cancel/$targetId');
      // print(response.data);
      // retrievedTarget = Target.fromJson(response.data);
    } on DioException catch (error) {
      print(error);
    }
    // return retrievedTarget; 
  }

}