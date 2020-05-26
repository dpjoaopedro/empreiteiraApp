import 'package:flutter/foundation.dart';

class BudgetItem {
  final String id;
  final String budgetId;
  final String title;
  final String price;

  BudgetItem({
    this.id,
    @required this.budgetId,
    @required this.price,
    @required this.title,
  });
  
}
