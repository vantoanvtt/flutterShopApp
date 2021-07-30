import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/inner_screens/product_details/product_details.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/feeds/components/feeds_dialog.dart';

class FeedProducts extends StatefulWidget {
  @override
  _FeedProductsState createState() => _FeedProductsState();
}

class _FeedProductsState extends State<FeedProducts> {
  @override
  Widget build(BuildContext context) {
    final productsAttributes = Provider.of<Product>(context);
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
          arguments: productsAttributes.id),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: 250,
          height: 310,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Theme.of(context).backgroundColor),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Image.network(
                        productsAttributes.imageUrl,
                        //fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Badge(
                    toAnimate: true,
                    shape: BadgeShape.square,
                    badgeColor: Colors.pink,
                    borderRadius: BorderRadius.circular(8),
                    badgeContent:
                        Text('New', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.only(left: 5, bottom: 2, right: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      productsAttributes.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        '\$ ' + productsAttributes.price.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantity: ' + productsAttributes.quantity.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) => FeedDialog(
                                          productId: productsAttributes.id,
                                        ));
                              },
                              borderRadius: BorderRadius.circular(18.0),
                              child: Icon(
                                Icons.more_horiz,
                                color: Colors.grey,
                              )),
                        )
                      ],
                    ),
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
