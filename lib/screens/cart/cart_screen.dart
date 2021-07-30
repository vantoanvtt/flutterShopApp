import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/my_icons.dart';
import 'package:shop_app/providers/carts_provider.dart';
import 'package:shop_app/screens/cart/components/cart_empty.dart';
import 'package:shop_app/screens/cart/components/cart_full.dart';
import 'package:shop_app/services/global_methods.dart';
import 'package:shop_app/services/payment.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeService.init();
  }

  var response;
  Future<void> payWithCard({int amount = 0}) async {
    ProgressDialog dialog = ProgressDialog(context: context);
    //dialog.style(message: 'Please wait...');
    //await dialog.show(max: 100, msg: "Please wait...");
    response = await StripeService.payWithNewCard(
        currency: 'USD', amount: amount.toString());

    //dialog.close();
    print('response : ${response.success}');
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration: Duration(milliseconds: response.success == true ? 1200 : 3000),
    ));
  }

  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = new GlobalMethods();
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: CartEmpty(),
          )
        : Scaffold(
            bottomSheet: buildBottomSheet(context, cartProvider.totalAmount),
            appBar: AppBar(
              title: Text('Cart (${cartProvider.getCartItems.length})'),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showDialogg(
                        'Clear cart!',
                        'Your cart will be cleared!',
                        () => cartProvider.clearCart(),
                        context);
                    // cartProvider.clearCart();
                  },
                  icon: Icon(MyAppIcon.trash),
                )
              ],
            ),
            body: CartFull(),
          );
  }

  Container buildBottomSheet(BuildContext context, double total) {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: [
                    Colors.purple,
                    Colors.pink,
                  ], stops: [
                    0.0,
                    0.7
                  ]),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      payWithCard(amount: total.toInt());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Checkout',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Text(
              'Total:',
              style: TextStyle(
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              'US \$${total.toStringAsFixed(2)}',
              //textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
