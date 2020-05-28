import 'dart:math';

import 'package:empreiteiraApp/data/dummy_data.dart';
import 'package:empreiteiraApp/models/budget_model.dart';
import 'package:flutter/cupertino.dart';

class BudgetProvider with ChangeNotifier {
  List<BudgetModel> _budgets = dummyData;

  List<BudgetModel> get budgets => [..._budgets];

  void addBudget(BudgetModel budget) {
    if (budget.id == null) {
      budget.id = Random().nextDouble().toString();
      _budgets.add(budget);
    } else {
      final index = _budgets.indexWhere((item) => item.id == budget.id);
      if (index >= 0) {
        _budgets[index] = budget;
      }
    }
    notifyListeners();
  }

  void removeBudget(String id) {
    final index = _budgets.indexWhere((product) => product.id == id);
    if (index < 0) return;
    _budgets.removeWhere((budget) => budget.id == id);
    notifyListeners();
  }
}
