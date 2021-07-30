import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/colors.dart';
import 'package:shop_app/inner_screens/brands_navigation_screen/brands_navigation_rail.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/feeds/feeds_screen.dart';

import 'category_widget.dart';
import 'popular_product.dart';

class FrontLayer extends StatelessWidget {
  const FrontLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    productsData.FetchProducts();
    final popularItems = productsData.popularProducts;
    List _carouselImages = [
      'assets/images/carousel1.png',
      'assets/images/carousel2.jpeg',
      'assets/images/carousel3.jpg',
      'assets/images/carousel4.png',
    ];
    List _brandImages = [
      'assets/images/addidas.jpg',
      'assets/images/apple.jpg',
      'assets/images/dell.jpg',
      'assets/images/h&m.jpg',
      'assets/images/nike.jpg',
      'assets/images/samsung.jpg',
      'assets/images/huawei.jpg',
    ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 190.0,
            width: double.infinity,
            child: Carousel(
              boxFit: BoxFit.fill,
              autoplay: true,
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: Duration(milliseconds: 1000),
              dotSize: 5.0,
              dotIncreasedColor: Colors.purple,
              dotBgColor: Colors.black.withOpacity(0.2),
              dotPosition: DotPosition.bottomCenter,
              showIndicator: true,
              indicatorBgPadding: 5.0,
              images: [
                ExactAssetImage(_carouselImages[0]),
                ExactAssetImage(_carouselImages[1]),
                ExactAssetImage(_carouselImages[2]),
                ExactAssetImage(_carouselImages[3]),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Categories',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          Container(
              height: 180,
              width: double.infinity,
              child: ListView.builder(
                itemCount: 7,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext ctx, int index) {
                  return CategoryWidget(
                    index: index,
                  );
                },
              )),
          contentHeader(() {
            Navigator.of(context)
                .pushNamed(BrandNavigationRailScreen.routeName, arguments: {7});
          }, 'Popular Brands'),
          Container(
            height: 210,
            width: MediaQuery.of(context).size.width * 0.95,
            child: Swiper(
              itemCount: _brandImages.length,
              autoplay: true,
              viewportFraction: 0.8,
              scale: 0.9,
              onTap: (index) {
                Navigator.of(context).pushNamed(
                  BrandNavigationRailScreen.routeName,
                  arguments: {
                    index,
                  },
                );
              },
              itemBuilder: (BuildContext ctx, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.blueGrey,
                    child: Image.asset(
                      _brandImages[index],
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
          ),
          contentHeader(() {
            Navigator.of(context)
                .pushNamed(FeedsScreen.routeName, arguments: "popular");
          }, 'Popular Products'),
          Container(
            width: double.infinity,
            height: 285,
            margin: EdgeInsets.symmetric(horizontal: 3),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularItems.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return ChangeNotifierProvider.value(
                    value: popularItems[index],
                    child: PopularProduct(),
                  );
                }),
          ),
          contentHeader(() {}, 'Viewed recently'),
        ],
      ),
    );
  }
}

Padding contentHeader(Function onTap, String title) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ),
        Spacer(),
        InkWell(
          onTap: () {
            onTap();
          },
          child: Text(
            'View all...',
            style: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 15, color: Colors.red),
          ),
        )
      ],
    ),
  );
}
