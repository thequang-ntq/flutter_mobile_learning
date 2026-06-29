// import 'dart:collection';

import 'dart:collection';

import 'package:code_learning_flutter/setstate/state_management/models/item_model.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<ItemModel> _items = [];
  UnmodifiableListView<ItemModel> get items => UnmodifiableListView(_items);
  int get totalPrice => _items.fold(0, (sum, item) => sum + item.price);

  void add(ItemModel item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(ItemModel item) {
    _items.removeWhere((i) => i.id == item.id);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  bool isInCart(ItemModel item) {
    return _items.any((i) => i.id == item.id);
  }
}
