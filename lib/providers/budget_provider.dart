import 'package:empreiteiraApp/data/dummy_data.dart';
import 'package:empreiteiraApp/models/budget_model.dart';
import 'package:flutter/cupertino.dart';

class BudgetProvider with ChangeNotifier {

  List<BudgetModel> _budgets = dummyData;

  List<BudgetModel> get budgets => [..._budgets];

}