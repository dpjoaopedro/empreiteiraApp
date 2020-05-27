import 'package:empreiteiraApp/models/budget.dart';
import 'package:empreiteiraApp/models/budget_item_model.dart';
import 'package:empreiteiraApp/models/client.dart';
import 'package:empreiteiraApp/models/payment_item.dart';

final dummyData = [
  BudgetModel(
    id: '1',
    title: 'Orçamento 1',
    price: 1500,
    client: Client(id: '1', cod: '100.899.946-66', name: 'Funalo da Silva'),
    date: DateTime.now(),
    items: [
      BudgetItemModel(budgetId: '1', title: 'Alvenaria'),
      BudgetItemModel(budgetId: '1', title: 'Reboco'),
    ],
    payments: [
      PaymentItem(id: '1', description: 'Entrada - R\$ 1.000,00 para mobilização', date: DateTime.now()),
      PaymentItem(id: '2', description: 'Restante - R\$ 500,00 na entrega total da obra', date: DateTime.now())
    ],
  ),
];
