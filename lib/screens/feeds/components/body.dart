import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products_provider.dart';

import 'feeds_products.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    List<Product> products = productsProvider.products;
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 240 / 350,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      children: List.generate(
          products.length,
          (index) => ChangeNotifierProvider.value(
                value: products[index],
                child: FeedProducts(),
              )),
    );
  }
}
