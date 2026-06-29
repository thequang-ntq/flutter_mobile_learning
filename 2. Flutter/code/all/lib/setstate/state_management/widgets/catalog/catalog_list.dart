import 'package:code_learning_flutter/setstate/state_management/models/catalog_model.dart';
import 'package:code_learning_flutter/setstate/state_management/models/item_model.dart';
import 'package:code_learning_flutter/setstate/state_management/services/catalog_service.dart';
import 'package:code_learning_flutter/setstate/state_management/widgets/catalog/catalog_item.dart';
import 'package:flutter/material.dart';

class CatalogList extends StatelessWidget {
  const CatalogList({super.key, required this.numberOfItem});
  final int numberOfItem;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.03, w * 0.09, h * 0.03),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    final catalog = CatalogModel(CatalogService());
    catalog.getAll(size: numberOfItem);
    final items = catalog.items;
    final h = MediaQuery.of(context).size.height;

    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, position) {
        return _buildListItem(position: position, item: items[position]);
      },
      separatorBuilder: (context, position) {
        return SizedBox(height: h * 0.02);
      },
      physics: const ClampingScrollPhysics(),
    );
  }

  Widget _buildListItem({required int position, required ItemModel item}) {
    return CatalogItem(position: position, item: item);
  }
}
