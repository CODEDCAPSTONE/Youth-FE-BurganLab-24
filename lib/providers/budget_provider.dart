import 'package:flutter/material.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/services/budget.dart';

class BudgetProvider extends ChangeNotifier {
  var budget;
  var spent;

  List title = ["Online Shopping", "Dining", "Fuel", "Entertainment"];
  List categories = ["onlineShopping", "dining", "fuel", "entertainment"];

  Future getBudget() async {
    try {
      if (budget == null || true) {
        await AuthProvider().initAuth();
        var response = await BudgetServices().getBudget();
        budget = response["budget"];
        spent = response["spent"];
        // print(spent);
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

  Future editBudget(Map<String, int> request) async {
    try {
      var response = await BudgetServices().editBudget(request);
      // print(budget);
      return response;

    } on Exception catch (_) {
      rethrow;
    }
  }

  void clear() {
    budget = null;
    spent = null;
  }
}