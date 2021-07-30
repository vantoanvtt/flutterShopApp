import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/colors.dart';
import 'package:shop_app/consts/my_icons.dart';
import 'package:shop_app/providers/carts_provider.dart';
import 'package:shop_app/providers/dark_theme_povider.dart';
import 'package:shop_app/providers/favs_provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/feeds/components/feeds_products.dart';
import 'package:shop_app/screens/wish_list/wish_list_screen.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);
  static String routeName = "/DetailsScreen";

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    print('productId $productId');
    final prodAttr = productsData.findById(productId);
    final productsList = productsData.products;
    final favsProvider = Provider.of<FavsProvider>(context);

    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Product details"),
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
      body: Stack(
        children: [
          Container(
            foregroundDecoration: BoxDecoration(color: Colors.black12),
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: Image.network(
              prodAttr.imageUrl,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 230,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.save,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.share,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prodAttr.title,
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "US \$" + prodAttr.price.toString(),
                        style: TextStyle(
                            color: themeState.darkTheme
                                ? Theme.of(context).disabledColor
                                : ColorsConsts.subTitle,
                            fontWeight: FontWeight.bold,
                            fontSize: 21.0),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 1,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        prodAttr.description,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 21.0,
                          color: themeState.darkTheme
                              ? Theme.of(context).disabledColor
                              : ColorsConsts.subTitle,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 1,
                      ),
                      _detailsWidget(true, "Brand", prodAttr.brand),
                      _detailsWidget(
                          true, "Quantity", prodAttr.quantity.toString()),
                      _detailsWidget(
                          true, "Category", prodAttr.productCategoryName),
                      _detailsWidget(true, "Popularity",
                          prodAttr.isPopular ? 'Popular' : 'Barely known'),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 1,
                      ),
                      Container(
                          color: Theme.of(context).backgroundColor,
                          width: double.infinity,
                          height: 120,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10.0),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'No reviews yet',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 21.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    'Be the first review!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20.0,
                                      color: themeState.darkTheme
                                          ? Theme.of(context).disabledColor
                                          : ColorsConsts.subTitle,
                                    ),
                                  ),
                                ),
                              ])),
                      SizedBox(
                        height: 70,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 1,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Text(
                    'Suggested products:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  height: 300,
                  child: ListView.builder(
                    itemCount:
                        productsList.length > 7 ? 7 : productsList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctx, int index) {
                      return ChangeNotifierProvider.value(
                          value: productsList[index], child: FeedProducts());
                    },
                  ),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(side: BorderSide.none),
                      color: Colors.redAccent.shade400,
                      onPressed:
                          cartProvider.getCartItems.containsKey(productId)
                              ? () {}
                              : () {
                                  cartProvider.addProductToCart(
                                      productId,
                                      prodAttr.price,
                                      prodAttr.title,
                                      prodAttr.imageUrl);
                                },
                      child: Text(
                        cartProvider.getCartItems.containsKey(productId)
                            ? 'In cart'
                            : 'Add to Cart'.toUpperCase(),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(side: BorderSide.none),
                      color: Theme.of(context).backgroundColor,
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'Buy now'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.payment,
                            color: Colors.green.shade700,
                            size: 19,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: themeState.darkTheme
                        ? Theme.of(context).disabledColor
                        : ColorsConsts.subTitle,
                    height: 50,
                    child: InkWell(
                      splashColor: ColorsConsts.favColor,
                      onTap: () {
                        favsProvider.addAndRemoveFromFav(productId,
                            prodAttr.price, prodAttr.title, prodAttr.imageUrl);
                      },
                      child: Center(
                        child: Icon(
                          favsProvider.getFavsItems.containsKey(productId)
                              ? Icons.favorite
                              : MyAppIcon.wishlist,
                          color:
                              favsProvider.getFavsItems.containsKey(productId)
                                  ? Colors.red
                                  : ColorsConsts.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ]))
        ],
      ),
    );
  }

  Widget _detailsWidget(bool themeState, String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title + ": ",
            style: TextStyle(
                color: Theme.of(context).textSelectionTheme.selectionColor,
                fontWeight: FontWeight.w600,
                fontSize: 21.0),
          ),
          Text(
            info,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20.0,
              color: themeState
                  ? Theme.of(context).disabledColor
                  : ColorsConsts.subTitle,
            ),
          ),
        ],
      ),
    );
  }
}
