import 'package:flutter/foundation.dart';

class BudgetItem {
  final String id;
  final String budgetId;
  final String title;

  BudgetItem({
    this.id,
    @required this.budgetId,
    @required this.title,
  });
  
}
