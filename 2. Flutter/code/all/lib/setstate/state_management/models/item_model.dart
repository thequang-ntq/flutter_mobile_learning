import 'package:flutter/painting.dart';

class ItemModel {
  final String id;
  final Color color;
  final String name;
  final int price;

  ItemModel({
    required this.id,
    required this.color,
    required this.name,
    required this.price,
  });
}
