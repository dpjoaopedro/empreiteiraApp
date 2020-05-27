import 'package:flutter/foundation.dart';

class PaymentItemModel {
  final String id;
  final String description;
  final DateTime date;

  PaymentItemModel({
    this.id,
    @required this.description,
    @required this.date,
  });
}
