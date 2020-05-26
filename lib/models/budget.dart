import 'package:empreiteiraApp/models/budget_item.dart';
import 'package:empreiteiraApp/models/payment_item.dart';
import 'package:flutter/foundation.dart';

class Budget {
  final String id;
  final String title;
  final double price;
  final List<BudgetItem> items;
  final List<PaymentItem> payments;

  Budget({
    this.id,
    @required this.title,
    @required this.price,
    @required this.items,
    @required this.payments,
  });
}
