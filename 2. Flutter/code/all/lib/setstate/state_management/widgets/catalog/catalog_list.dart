import 'package:code_learning_flutter/setstate/state_management/models/catalog_model.dart';
import 'package:code_learning_flutter/setstate/state_management/models/item_model.dart';
import 'package:code_learning_flutter/setstate/state_management/widgets/catalog/catalog_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogList extends StatefulWidget {
  const CatalogList({super.key, required this.numberOfItem});
  final int numberOfItem;

  @override
  State<CatalogList> createState() => _CatalogListState();
}

class _CatalogListState extends State<CatalogList> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CatalogModel>().getAll(size: widget.numberOfItem);
    });
  }

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
    final h = MediaQuery.of(context).size.height;

    return Consumer<CatalogModel>(
      builder: (context, catalog, _) {
        return ListView.separated(
          itemCount: catalog.items.length,
          itemBuilder: (context, position) {
            return _buildListItem(
              position: position,
              item: catalog.items[position],
            );
          },
          separatorBuilder: (context, position) {
            return SizedBox(height: h * 0.02);
          },
          physics: const ClampingScrollPhysics(),
        );
      },
    );
  }

  Widget _buildListItem({required int position, required ItemModel item}) {
    return CatalogItem(position: position, item: item);
  }
}
