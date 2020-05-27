import 'package:empreiteiraApp/models/budget.dart';
import 'package:empreiteiraApp/models/budget_item.dart';
import 'package:empreiteiraApp/models/payment_item.dart';

final dummyData = [
  Budget(
    id: '1',
    title: 'Orçamento 1',
    price: 1500,
    date: DateTime.now(),
    items: [
      BudgetItem(budgetId: '1', title: 'Alvenaria'),
      BudgetItem(budgetId: '1', title: 'Reboco'),
    ],
    payments: [
      PaymentItem(id: '1', description: 'Entrada - R\$ 1.000,00 para mobilização', date: DateTime.now()),
      PaymentItem(id: '2', description: 'Restante - R\$ 500,00 na entrega total da obra', date: DateTime.now())
    ],
  ),
];
