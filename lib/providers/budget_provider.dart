import 'package:flutter/material.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/services/budget.dart';

class BudgetProvider extends ChangeNotifier {
  List budget = [];

  Future getBudget() async {
    try {
      if (budget.isEmpty) {
        await AuthProvider().initAuth();
        var response = await BudgetServices().getBudget();
        budget = response;
      }
      // print(budget);
      return budget;

    } on Exception catch (_) {
      rethrow;
    }
  }

  Future setBudget(Map<String, int> request) async {
    try {
      var response = await BudgetServices().setBudget(request);
      // print(budget);
      return response;

    } on Exception catch (_) {
      rethrow;
    }
  }
}