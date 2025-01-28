import 'package:flutter/material.dart';
import 'package:frontend/models/target.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/services/target.dart';

class TargetsProvider extends ChangeNotifier {
  List<Target> targets = [];

  Future<List<Target>> getTargets() async {
    try {
      await AuthProvider().initAuth();
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

  Future<void> deleteTarget(String targetId) async {
    await TargetServices().deleteTarget(targetId);
    targets = [];
    notifyListeners(); 
  }

  void clear() {
    targets = [];
  }
}