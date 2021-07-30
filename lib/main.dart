import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/theme_data.dart';
import 'package:shop_app/inner_screens/categories_feeds/categories_feeds_screen.dart';
import 'package:shop_app/inner_screens/product_details/product_details.dart';
import 'package:shop_app/inner_screens/upload_screen/upload_screen.dart';
import 'package:shop_app/providers/carts_provider.dart';
import 'package:shop_app/providers/dark_theme_povider.dart';
import 'package:shop_app/providers/favs_provider.dart';
import 'package:shop_app/providers/orders_provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/bottom_bar.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/feeds/feeds_screen.dart';
import 'package:shop_app/screens/forget_password/forget_password.dart';
import 'package:shop_app/screens/landing_page/landing_page_screen.dart';
import 'package:shop_app/screens/login/login_screen.dart';
import 'package:shop_app/screens/main_screen.dart';
import 'package:shop_app/screens/orders/order.dart';
import 'package:shop_app/screens/sign_up/sign_up_screen.dart';
import 'package:shop_app/screens/user_state.dart';
import 'package:shop_app/screens/wish_list/wish_list_screen.dart';

import 'inner_screens/brands_navigation_screen/brands_navigation_rail.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error occured'),
                ),
              ),
            );
          }
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => themeChangeProvider),
                ChangeNotifierProvider(
                  create: (_) => Products(),
                ),
                ChangeNotifierProvider(
                  create: (_) => CartProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => FavsProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => OrdersProvider(),
                ),
              ],
              child: Consumer<DarkThemeProvider>(
                builder: (context, themeData, child) {
                  return MaterialApp(
                      title: 'Flutter Demo',
                      theme: Styles.themeData(
                          themeChangeProvider.darkTheme, context),
                      debugShowCheckedModeBanner: false,
                      home: UserState(),
                      routes: {
                        BrandNavigationRailScreen.routeName: (ctx) =>
                            BrandNavigationRailScreen(),
                        CartScreen.routeName: (ctx) => CartScreen(),
                        FeedsScreen.routeName: (ctx) => FeedsScreen(),
                        WishListScreen.routeName: (ctx) => WishListScreen(),
                        ProductDetails.routeName: (ctx) => ProductDetails(),
                        CategoriesFeedsScreen.routeName: (ctx) =>
                            CategoriesFeedsScreen(),
                        LoginScreen.routeName: (ctx) => LoginScreen(),
                        SignUpScreen.routeName: (ctx) => SignUpScreen(),
                        ForgetPassword.routeName: (ctx) => ForgetPassword(),
                        BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
                        UploadProductForm.routeName: (ctx) =>
                            UploadProductForm(),
                        OrderScreen.routeName: (ctx) => OrderScreen(),
                      });
                },
              ));
        });
  }
}
