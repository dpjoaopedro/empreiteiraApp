import 'package:empreiteiraApp/pages/budget_form_page/budget_form_page.dart';
import 'package:flutter/material.dart';

class BudgetFloatingButtons extends StatelessWidget {

  final BudgetFormStatus status;
  final Function onNavigateNext;
  final Function onNavigateBack;

  BudgetFloatingButtons(this.status, this.onNavigateBack, this.onNavigateNext);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
            backgroundColor: status == BudgetFormStatus.description
                ? Colors.grey
                : Theme.of(context).accentColor,
            onPressed: status != BudgetFormStatus.description
                ? onNavigateBack
                : null,
            child: Icon(Icons.navigate_before),
            heroTag: null,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            backgroundColor: status == BudgetFormStatus.adding_payments
                ? Colors.grey
                : Theme.of(context).accentColor,
            onPressed: status != BudgetFormStatus.adding_payments
                ? onNavigateNext
                : null,
            child: Icon(Icons.navigate_next),
            heroTag: null,
          ),
        ),
      ],
    );
  }
}
