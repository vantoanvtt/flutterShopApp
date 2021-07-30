import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/consts/colors.dart';
import 'package:shop_app/consts/my_icons.dart';
import 'package:shop_app/providers/dark_theme_povider.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/orders/order.dart';
import 'package:shop_app/screens/wish_list/wish_list_screen.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool _value = false;

  late ScrollController _scrollController;
  var top = 0.0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _uid;
  String _name = "";
  String? _email;
  String? _joinedAt;
  String? _userImageUrl;
  int? _phoneNumber;
  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    getData();
    super.initState();
  }

  void getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;

    print('user.displayName ${user.displayName}');
    print('user.photoURL ${user.photoURL}');
    final DocumentSnapshot<Map<String, dynamic>>? userDoc = user.isAnonymous
        ? null
        : await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (userDoc == null) {
      return;
    } else {
      setState(() {
        _name = userDoc.get('name');
        _email = user.email;
        _joinedAt = userDoc.get('joinedAt');
        _phoneNumber = userDoc.get('phoneNumber');
        _userImageUrl = userDoc.get('imageUrl');
      });
    }
    // print("name $_name");
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  elevation: 4,
                  expandedHeight: 200,
                  pinned: true,
                  flexibleSpace: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      top = constraints.biggest.height;
                      return Container(
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
                        child: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          centerTitle: true,
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 300),
                                opacity: top <= 110.0 ? 1.0 : 0,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      height: kToolbarHeight / 1.8,
                                      width: kToolbarHeight / 1.8,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(_userImageUrl ??
                                              'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      // 'top.toString()',
                                      _name == null ? 'Guest' : _name,
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          background: Image(
                            image: NetworkImage(_userImageUrl ??
                                'https://t3.ftcdn.net/jpg/01/83/55/76/240_F_183557656_DRcvOesmfDl5BIyhPKrcWANFKy2964i9.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: userTitle('User Bag')),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Theme.of(context).splashColor,
                          child: ListTile(
                            onTap: () => Navigator.of(context)
                                .pushNamed(WishListScreen.routeName),
                            title: Text('Wishlist'),
                            trailing: Icon(Icons.chevron_right_rounded),
                            leading: Icon(MyAppIcon.wishlist),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Theme.of(context).splashColor,
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(CartScreen.routeName);
                            },
                            title: Text('Cart'),
                            trailing: Icon(Icons.chevron_right_rounded),
                            leading: Icon(MyAppIcon.cart),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Theme.of(context).splashColor,
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(OrderScreen.routeName);
                            },
                            title: Text('order'),
                            trailing: Icon(Icons.chevron_right_rounded),
                            leading: Icon(MyAppIcon.bag),
                          ),
                        ),
                      ),
                      userTitle("User Infomation"),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      userListTitle(context, "email", _email ?? '', 0, () {}),
                      userListTitle(context, "phone number",
                          _phoneNumber.toString() ?? "", 1, () {}),
                      userListTitle(
                          context, "shipping address", "sub", 2, () {}),
                      userListTitle(
                          context, "joined date", _joinedAt ?? '', 3, () {}),
                      userTitle("Users Setting"),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      ListTileSwitch(
                        value: themeChange.darkTheme,
                        leading: Icon(Ionicons.md_moon),
                        onChanged: (value) {
                          setState(() {
                            themeChange.darkTheme = value;
                          });
                        },
                        visualDensity: VisualDensity.comfortable,
                        switchType: SwitchType.cupertino,
                        switchActiveColor: Colors.indigo,
                        title: Text('Dark mode'),
                      ),
                      userListTitle(context, "Logout", "", 4, () {
                        showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                title: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 6.0),
                                      child: Image.network(
                                        'https://image.flaticon.com/icons/png/128/1828/1828304.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Sign out'),
                                    ),
                                  ],
                                ),
                                content: Text('Do you wanna Sign out?'),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel')),
                                  TextButton(
                                      onPressed: () async {
                                        await _auth.signOut().then(
                                            (value) => Navigator.pop(context));
                                      },
                                      child: Text(
                                        'Ok',
                                        style: TextStyle(color: Colors.red),
                                      ))
                                ],
                              );
                            });
                      })
                    ],
                  ),
                )
              ],
            ),
            _buildFab()
          ],
        ),
      ),
    );
  }

  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 200.0 - 28;
    //pixels from top where scaling should start
    final double scaleStart = 160.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      print(offset);
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          heroTag: "btn1",
          onPressed: () {},
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  Padding userTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 8, top: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
      ),
    );
  }

  Material userListTitle(BuildContext context, String title, String subTitle,
      int index, Function onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: ListTile(
          onTap: () {
            onTap();
          },
          title: Text(title),
          subtitle: Text(subTitle),
          leading: Icon(UserTitleIcon[index]),
        ),
      ),
    );
  }

  List<IconData> UserTitleIcon = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app_outlined
  ];
}
