import 'package:flutter/foundation.dart';

class PaymentItem {
  final String id;
  final String description;
  final DateTime date;

  PaymentItem({
    this.id,
    @required this.description,
    @required this.date,
  });
}
