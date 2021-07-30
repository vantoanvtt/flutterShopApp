import 'package:flutter/material.dart';
import 'package:shop_app/inner_screens/categories_feeds/categories_feeds_screen.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> categories = [
      {
        'categoryName': 'Phones',
        'categoryImagesPath': 'assets/images/CatPhones.png',
      },
      {
        'categoryName': 'Clothes',
        'categoryImagesPath': 'assets/images/CatClothes.jpg',
      },
      {
        'categoryName': 'Shoes',
        'categoryImagesPath': 'assets/images/CatShoes.jpg',
      },
      {
        'categoryName': 'Beauty&Health',
        'categoryImagesPath': 'assets/images/CatBeauty.jpg',
      },
      {
        'categoryName': 'Laptops',
        'categoryImagesPath': 'assets/images/CatLaptops.png',
      },
      {
        'categoryName': 'Furniture',
        'categoryImagesPath': 'assets/images/CatFurniture.jpg',
      },
      {
        'categoryName': 'Watches',
        'categoryImagesPath': 'assets/images/CatWatches.jpg',
      },
    ];

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(CategoriesFeedsScreen.routeName,
            arguments: '${categories[index]['categoryName']}');
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(
                      categories[this.index]['categoryImagesPath'].toString()),
                  fit: BoxFit.cover),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150,
          ),
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              color: Theme.of(context).backgroundColor,
              child: Text(
                categories[index]['categoryName'].toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Theme.of(context).textSelectionColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
