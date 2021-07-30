import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/my_icons.dart';
import 'package:shop_app/providers/favs_provider.dart';
import 'package:shop_app/screens/wish_list/components/wish_list_empty.dart';
import 'package:shop_app/screens/wish_list/components/wish_list_full.dart';
import 'package:shop_app/services/global_methods.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);
  static const routeName = '/WishlistScreen';

  @override
  Widget build(BuildContext context) {
    final favsProvider = Provider.of<FavsProvider>(context);
    GlobalMethods globalMethods = new GlobalMethods();
    return favsProvider.getFavsItems.isEmpty
        ? Scaffold(
            body: WishListEmpty(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Wish List(${favsProvider.getFavsItems.length})"),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showDialogg(
                        'Clear wishlist!',
                        'Your wishlist will be cleared!',
                        () => favsProvider.clearFavs(),
                        context);
                    // cartProvider.clearCart();
                  },
                  icon: Icon(MyAppIcon.trash),
                )
              ],
            ),
            body: ListView.builder(
                itemCount: favsProvider.getFavsItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ChangeNotifierProvider.value(
                    value: favsProvider.getFavsItems.values.toList()[index],
                    child: WishListFull(
                      favsId: favsProvider.getFavsItems.keys.toList()[index],
                    ),
                  );
                }),
          );
  }
}
