
import 'package:empreiteiraApp/models/budget_model.dart';
import 'package:empreiteiraApp/shared/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BudgetListItemWidget extends StatelessWidget {
  final BudgetModel budget;
  BudgetListItemWidget(this.budget);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          width: 80, child: FittedBox(child: Text('R\$ ${budget.price.toStringAsFixed(2)}'))),
      title: Text(budget.title, overflow: TextOverflow.clip),
      subtitle: Text(DateFormat('dd/MM/yyyy').format(budget.date)),
      onTap: () => {Navigator.of(context).pushNamed(AppRoutes.BUDGET, arguments: budget)},
      trailing: IconButton(icon: Icon(Icons.share), onPressed: () => {},),
    );
  }
}