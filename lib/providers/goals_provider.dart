import 'package:flutter/material.dart';

class Goal {
  String name;
  double amount;
  int duration;

  Goal({required this.name, required this.amount, required this.duration});
}

class GoalsProvider extends ChangeNotifier {
  List<Goal> list = List.generate(
      4,
      (i) => Goal(
          name: "Goal ${i + 1}", amount: (i + 1) * 1000, duration: (i + 1)));

  void addGoal(Goal goal) {
    list.add(goal);
  }

  void updateGoal(Goal goal) {
    int index = list.indexWhere((g) => g.name == goal.name);
    list[index] = goal;
  }
}
