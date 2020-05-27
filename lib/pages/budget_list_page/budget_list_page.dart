import 'package:empreiteiraApp/components/app_drawer.dart';
import 'package:empreiteiraApp/components/budget_list_item.dart';
import 'package:empreiteiraApp/providers/budget_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BudgetProvider>(context);
    final budgets = provider.budgets;
    return Scaffold(
      appBar: AppBar(
        title: Text('Orçamentos'),
      ),
      drawer: AppDrawerWidget(),
      body: ListView.builder(
        itemCount: budgets.length,
        itemBuilder: (context, index) {
          return BudgetListItemWidget(budgets[index]);
        },
      ),
    );
  }
}