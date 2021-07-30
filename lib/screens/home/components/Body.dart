import 'package:backdrop/backdrop.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shop_app/consts/colors.dart';
import 'package:shop_app/screens/home/components/back_layer.dart';
import 'package:shop_app/screens/home/components/front_layer.dart';

import 'category_widget.dart';
import 'popular_product.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      headerHeight: MediaQuery.of(context).size.height * 0.25,
      appBar: buildBackDropAppBar(),
      backLayer: Backlayer(),
      frontLayer: FrontLayer(),
    );
  }

  BackdropAppBar buildBackDropAppBar() {
    return BackdropAppBar(
      title: Text("Home"),
      leading: BackdropToggleButton(icon: AnimatedIcons.home_menu),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(10),
          icon: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 13,
              backgroundImage: NetworkImage(
                  'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
            ),
          ),
        )
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [ColorsConsts.starterColor, ColorsConsts.endColor])),
      ),
    );
  }
}
