import 'package:flutter/foundation.dart';

class BudgetItemModel {
  final String id;
  final String budgetId;
  final String title;

  BudgetItemModel({
    this.id,
    @required this.budgetId,
    @required this.title,
  });
  
}
