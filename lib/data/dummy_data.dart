import 'package:empreiteiraApp/models/budget_item_model.dart';
import 'package:empreiteiraApp/models/budget_model.dart';
import 'package:empreiteiraApp/models/client_model.dart';
import 'package:empreiteiraApp/models/payment_item_model.dart';


final dummyData = [
  BudgetModel(
    id: '1',
    title: 'Orçamento 1',
    price: 1500,
    materialsAndTools: 'Todos os materiais e ferramentas são de responsabilidade do contratante',
    client: ClientModel(id: '1', cod: '100.899.946-66', name: 'Funalo da Silva'),
    date: DateTime.now(),
    items: [
      BudgetItemModel(id: '1', title: 'Alvenaria'),
      BudgetItemModel(id: '2', title: 'Reboco'),
    ],
    payments: [
      PaymentItemModel(id: '1', description: 'Entrada - R\$ 1.000,00 para mobilização', date: DateTime.now()),
      PaymentItemModel(id: '2', description: 'Restante - R\$ 500,00 na entrega total da obra', date: DateTime.now())
    ],
  ),
];
