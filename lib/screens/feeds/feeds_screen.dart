import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/colors.dart';
import 'package:shop_app/consts/my_icons.dart';
import 'package:shop_app/providers/carts_provider.dart';
import 'package:shop_app/providers/favs_provider.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/feeds/components/body.dart';
import 'package:shop_app/screens/feeds/components/feeds_products.dart';
import 'package:shop_app/screens/wish_list/wish_list_screen.dart';

class FeedsScreen extends StatelessWidget {
  static const routeName = '/FeedsScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text("Feeds"),
          actions: [
            Consumer<FavsProvider>(
              builder: (_, favs, ch) => Badge(
                badgeColor: ColorsConsts.cartBadgeColor,
                animationType: BadgeAnimationType.slide,
                toAnimate: true,
                position: BadgePosition.topEnd(top: 5, end: 7),
                badgeContent: Text(
                  favs.getFavsItems.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: Icon(
                    MyAppIcon.wishlist,
                    color: ColorsConsts.favColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(WishListScreen.routeName);
                  },
                ),
              ),
            ),
            Consumer<CartProvider>(
              builder: (_, cart, ch) => Badge(
                badgeColor: ColorsConsts.cartBadgeColor,
                animationType: BadgeAnimationType.slide,
                toAnimate: true,
                position: BadgePosition.topEnd(top: 5, end: 7),
                badgeContent: Text(
                  cart.getCartItems.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: Icon(
                    MyAppIcon.cart,
                    color: ColorsConsts.cartColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
              ),
            ),
          ],
        ),
        body: Body());
  }
}
