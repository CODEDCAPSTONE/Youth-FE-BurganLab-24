import 'package:flutter/material.dart';
import 'package:frontend/models/target.dart';
import 'package:frontend/services/target.dart';

class TargetsProvider extends ChangeNotifier {
  List<Target> targets = [];

  Future<List<Target>> getTargets() async {
    try {
      targets = await TargetServices().getTargets();
      // print(targets.first);
    } on Exception catch (_) {
      rethrow;
    }
    return targets;
  }

  Future<void> createTarget(Target target) async {
    Target newTarget = await TargetServices().createTarget(target);
    targets.add(newTarget);
    notifyListeners(); 
  }

}