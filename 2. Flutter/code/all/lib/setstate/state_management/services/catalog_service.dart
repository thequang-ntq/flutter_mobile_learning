import 'package:code_learning_flutter/setstate/state_management/models/item_model.dart';
import 'package:code_learning_flutter/setstate/state_management/utils/utils.dart';

class CatalogService {
  ItemModel _generateItem({required int position}) {
    return ItemModel(
      id: position.toString(),
      name: "Item #$position",
      color: randomColor(),
      price: 42,
    );
  }

  List<ItemModel> getAll({required int size}) {
    List<ItemModel> result = [];
    for (int i = 1; i <= size; i++) {
      result.add(_generateItem(position: i));
    }
    return result;
  }
}
