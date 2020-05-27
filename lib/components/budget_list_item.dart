import 'package:empreiteiraApp/models/budget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BudgetListItem extends StatelessWidget {
  final Budget budget;
  BudgetListItem(this.budget);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          width: 80, child: FittedBox(child: Text('R\$ ${budget.price}'))),
      title: Text(budget.title, overflow: TextOverflow.clip),
      subtitle: Text(DateFormat('dd/MM/yyyy').format(budget.date)),
      onTap: () => {},
    );
  }
}