import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/carts_provider.dart';
import 'package:shop_app/providers/favs_provider.dart';

class PopularProduct extends StatelessWidget {
  const PopularProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final favsProvider = Provider.of<FavsProvider>(context);
    final product = Provider.of<Product>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 170,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.contain)),
                  ),
                  Positioned(
                    right: 12,
                    top: 10,
                    child: Icon(
                      Entypo.star,
                      color: favsProvider.getFavsItems.containsKey(product.id)
                          ? Colors.red
                          : Colors.grey.shade800,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 7,
                    child: Icon(
                      Entypo.star_outlined,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    right: 12,
                    bottom: 32.0,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      color: Theme.of(context).backgroundColor,
                      child: Text(
                        '\$ ' + product.price.toString(),
                        style: TextStyle(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            product.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 1,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: cartProvider.getCartItems.containsKey(
                                product.id,
                              )
                                  ? () {}
                                  : () {
                                      cartProvider.addProductToCart(
                                          product.id,
                                          product.price,
                                          product.title,
                                          product.imageUrl);
                                    },
                              borderRadius: BorderRadius.circular(30.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  cartProvider.getCartItems
                                          .containsKey(product.id)
                                      ? MaterialCommunityIcons.check_all
                                      : MaterialCommunityIcons.cart_plus,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
