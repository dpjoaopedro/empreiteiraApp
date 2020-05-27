import 'package:empreiteiraApp/data/dummy_data.dart';
import 'package:empreiteiraApp/models/budget.dart';
import 'package:flutter/cupertino.dart';

class BudgetProvider with ChangeNotifier {

  List<Budget> _budgets = dummyData;

  List<Budget> get budgets => [..._budgets];

}