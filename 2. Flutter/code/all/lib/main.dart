import 'package:code_learning_flutter/app.dart';
import 'package:code_learning_flutter/setstate/state_management/models/cart_model.dart';
import 'package:code_learning_flutter/setstate/state_management/models/catalog_model.dart';
import 'package:code_learning_flutter/setstate/state_management/services/catalog_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(
          create: (context) => CatalogModel(CatalogService()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
