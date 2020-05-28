import 'package:empreiteiraApp/models/client_model.dart';
import 'package:empreiteiraApp/models/payment_item_model.dart';
import 'package:flutter/foundation.dart';

import 'budget_item_model.dart';

class BudgetModel {
   String id;
   String title;
   double price;
   DateTime date;
   ClientModel client;
   List<BudgetItemModel> items;
   List<PaymentItemModel> payments;

  BudgetModel({
    this.id,
    @required this.title,
    @required this.price,
    @required this.date,
    @required this.client,
    @required this.items,
    @required this.payments,
  });

  BudgetModel copy() {
    return new BudgetModel(
      id: this.id,
      title: this.title,
      price: this.price,
      date: this.date,
      client: this.client,
      items: [...this.items],
      payments: [...this.payments],
    );
  }
}
