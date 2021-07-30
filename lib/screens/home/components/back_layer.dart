import 'package:flutter/material.dart';
import 'package:shop_app/consts/colors.dart';
import 'package:shop_app/consts/my_icons.dart';
import 'package:shop_app/inner_screens/upload_screen/upload_screen.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/feeds/feeds_screen.dart';
import 'package:shop_app/screens/wish_list/wish_list_screen.dart';

class Backlayer extends StatelessWidget {
  const Backlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  ColorsConsts.starterColor,
                  ColorsConsts.endColor,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        positionedBox(
            top: -100.0, left: 140.0, angle: -0.5, width: 150.0, height: 250.0),
        positionedBox(
            bottom: 0.0,
            right: 100.0,
            angle: -0.8,
            width: 150.0,
            height: 300.0),
        positionedBox(
            top: -50.0, left: 60.0, angle: -0.5, width: 150.0, height: 200.0),
        positionedBox(
            bottom: 20.0, right: 0.0, angle: -0.8, width: 150.0, height: 200.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.all(8.0),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(height: 20),
            content(context, () {
              Navigator.pushNamed(
                context,
                FeedsScreen.routeName,
              );
            }, "Feeds", 0),
            content(context, () {
              Navigator.of(context).pushNamed(
                CartScreen.routeName,
              );
              print(
                  "tapppppp****************************************************************************************************");
            }, "Cart", 1),
            content(context, () {
              Navigator.of(context).pushNamed(
                WishListScreen.routeName,
              );
            }, "WishList", 2),
            content(context, () {
              Navigator.pushNamed(context, UploadProductForm.routeName);
            }, "Upload a new product", 3)
          ],
        )
      ],
    );
  }

  Positioned positionedBox({top, left, right, bottom, angle, width, height}) {
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white.withOpacity(0.3),
          ),
          width: width,
          height: height,
        ),
      ),
    );
  }
}

List _contentIcons = [
  MyAppIcon.rss,
  MyAppIcon.bag,
  MyAppIcon.wishlist,
  MyAppIcon.upload
];

Widget content(BuildContext ctx, Function fct, String text, int index) {
  return InkWell(
    onTap: () {
      fct();
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
        Icon(_contentIcons[index])
      ],
    ),
  );
}
