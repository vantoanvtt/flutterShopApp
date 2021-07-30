import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/colors.dart';
import 'package:shop_app/providers/dark_theme_povider.dart';
import 'package:shop_app/screens/feeds/feeds_screen.dart';

class WishListEmpty extends StatelessWidget {
  const WishListEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    // TODO: implement build
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BackButton(
            color: Colors.red,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 80),
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/empty-wishlist.png'),
                    fit: BoxFit.fill)),
          ),
          Text(
            'Your Wishlist Is Empty',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textSelectionColor,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Explore more and shortlist some items',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: themeChange.darkTheme
                    ? Theme.of(context).disabledColor
                    : ColorsConsts.subTitle,
                fontSize: 26,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.06,
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(FeedsScreen.routeName);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.red),
              ),
              color: Colors.redAccent,
              child: Text(
                'shop now'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).textSelectionColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
