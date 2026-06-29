import 'dart:collection';

import 'package:code_learning_flutter/setstate/state_management/models/item_model.dart';
import 'package:flutter/material.dart';

class CartList extends StatelessWidget {
  const CartList({super.key, required this.items});
  final UnmodifiableListView<ItemModel> items;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(w * 0.07, h * 0.03, w * 0.07, h * 0.03),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, position) {
            return _buildListItem(
              context,
              position: position,
              item: items[position],
            );
          },
          physics: const ClampingScrollPhysics(),
        ),
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required int position,
    required ItemModel item,
  }) {
    final text = Theme.of(context).textTheme;

    return ListTile(
      key: Key(item.id),
      title: Text(item.name, style: text.headlineSmall),
    );
  }
}
