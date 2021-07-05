import 'package:flutter/material.dart';
import 'package:udemy_course/screens/feeds.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<_CategoryItem> categories = [
    _CategoryItem('Phones', 'assets/images/CatPhones.png'),
    _CategoryItem('Clothes', 'assets/images/CatClothes.jpg'),
    _CategoryItem('Shoes', 'assets/images/CatShoes.jpg'),
    _CategoryItem('Beauty&Health', 'assets/images/CatBeauty.jpg'),
    _CategoryItem('Laptops', 'assets/images/CatLaptops.png'),
    _CategoryItem('Furniture', 'assets/images/CatFurniture.jpg'),
    _CategoryItem('Watches', 'assets/images/CatWatches.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, FeedsScreen.routeName);
            print('${categories[widget.index].name}');
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(categories[widget.index].imagePath),
                  fit: BoxFit.cover),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Theme.of(context).backgroundColor,
            child: Text(
              categories[widget.index].name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _CategoryItem {
  final String name;
  final String imagePath;

  const _CategoryItem(this.name, this.imagePath);
}
