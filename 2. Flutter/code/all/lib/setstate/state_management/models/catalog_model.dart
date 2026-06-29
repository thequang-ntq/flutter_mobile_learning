import 'dart:collection';

import 'package:code_learning_flutter/setstate/state_management/models/item_model.dart';
import 'package:code_learning_flutter/setstate/state_management/services/catalog_service.dart';

class CatalogModel {
  final CatalogService _service;
  CatalogModel(this._service);
  List<ItemModel> _items = [];
  UnmodifiableListView<ItemModel> get items => UnmodifiableListView(_items);

  void getAll({required int size}) {
    _items = _service.getAll(size: size);
  }
}
