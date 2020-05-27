
import 'package:empreiteiraApp/models/client_model.dart';
import 'package:empreiteiraApp/models/payment_item_model.dart';
import 'package:flutter/foundation.dart';

import 'budget_item_model.dart';

class BudgetModel {
  final String id;
  final String title;
  final double price;
  final DateTime date;
  final ClientModel client;
  final List<BudgetItemModel> items;
  final List<PaymentItemModel> payments;

  BudgetModel({
    this.id,
    @required this.title,
    @required this.price,
    @required this.date,
    @required this.client,
    @required this.items,
    @required this.payments,
  });
}