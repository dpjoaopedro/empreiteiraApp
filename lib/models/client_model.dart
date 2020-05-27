import 'package:flutter/foundation.dart';

class ClientModel {
  final String id;
  final String name;
  final String cod;

  ClientModel({
    this.id,
    @required this.name,
    @required this.cod,
  });
}
