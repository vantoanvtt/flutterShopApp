import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/my_icons.dart';
import 'package:shop_app/models/cart_attr.dart';
import 'package:shop_app/providers/carts_provider.dart';
import 'package:shop_app/services/global_methods.dart';

class CartFull extends StatefulWidget {
  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
        margin: EdgeInsets.only(bottom: 60),
        child: ListView.builder(
            itemCount: cartProvider.getCartItems.length,
            itemBuilder: (BuildContext ctx, int index) {
              return ChangeNotifierProvider.value(
                value: cartProvider.getCartItems.values.toList()[index],
                child: CartItem(
                  productId: cartProvider.getCartItems.keys.toList()[index],
                ),
              );
              // TODO: implement build
              throw UnimplementedError();
            }));
  }
}

class CartItem extends StatelessWidget {
  final String productId;
  const CartItem({required this.productId});

  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = new GlobalMethods();
    final cartProvider = Provider.of<CartProvider>(context);
    final cart = Provider.of<CartAttr>(context);
    double subTotal = cart.price * cart.quantity;
    return Container(
      height: 160,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), bottomRight: Radius.circular(16))),
      child: Row(
        children: [
          Container(
            width: 130,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(cart.imageUrl),
              //fit: BoxFit.fill,
            )),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            cart.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(32.0),
                          onTap: () {
                            globalMethods.showDialogg(
                                'Remove item!',
                                'Product will be removed from the cart!',
                                () => cartProvider.removeItem(productId),
                                context);
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 22,
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "price: ",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "${cart.price}\$",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "sub total: ",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "${subTotal.toStringAsFixed(2)}\$",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).accentColor),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "ships free",
                        style: TextStyle(fontSize: 15),
                      ),
                      Spacer(),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          // splashColor: ,
                          onTap: cart.quantity < 2
                              ? null
                              : () {
                                  cartProvider.reduceItemByOne(
                                    productId,
                                  );
                                },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.remove,
                                color: cart.quantity > 2
                                    ? Colors.red
                                    : Colors.grey,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 12,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.purple,
                              Colors.pink,
                            ], stops: [
                              0.0,
                              0.7
                            ]),
                          ),
                          child: Text(
                            cart.quantity.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          // splashColor: ,
                          onTap: () {
                            cartProvider.addProductToCart(productId, cart.price,
                                cart.title, cart.imageUrl);
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.add,
                                color: Colors.red,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
