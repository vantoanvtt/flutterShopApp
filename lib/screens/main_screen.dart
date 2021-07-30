import 'package:flutter/material.dart';
import 'package:shop_app/inner_screens/upload_screen/upload_screen.dart';
import 'package:shop_app/screens/bottom_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [BottomBarScreen(), UploadProductForm()],
    );
  }
}
