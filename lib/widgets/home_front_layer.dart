import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

import '/screens/brands_navigation_rail.dart';
import 'category.dart';
import 'popular_products.dart';

class HomeFrontLayer extends StatelessWidget {
  final List _carouselIcons = [
    'assets/images/carousel1.png',
    'assets/images/carousel2.jpeg',
    'assets/images/carousel3.jpg',
    'assets/images/carousel4.png',
  ];

  final List _brandImages = [
    'assets/images/addidas.jpg',
    'assets/images/apple.jpg',
    'assets/images/dell.jpg',
    'assets/images/h&m.jpg',
    'assets/images/nike.jpg',
    'assets/images/samsung.jpg',
    'assets/images/huawei.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                dotVerticalPadding: 0.0,
                showIndicator: true,
                indicatorBgPadding: 7.0,
                images: List.generate(
                    _carouselIcons.length,
                    (index) =>
                        Image(image: ExactAssetImage(_carouselIcons[index])))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Categories',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          Container(
            width: double.infinity,
            height: 180,
            child: ListView.builder(
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext ctx, int index) {
                return CategoryWidget(
                  index: index,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Brands',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        BrandNavigationRailScreen.routeName,
                        arguments: {
                          7,
                        },
                      );
                    },
                    child: Text(
                      'View all...',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Colors.red),
                    ),
                  ),
                ]),
          ),
          Container(
            height: 210,
            width: MediaQuery.of(context).size.width * 0.95,
            child: Swiper(
              itemCount: _brandImages.length,
              autoplay: true,
              viewportFraction: 0.8,
              scale: 0.9,
              itemBuilder: (BuildContext ctx, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      child: Image.asset(
                    _brandImages[index],
                    fit: BoxFit.fill,
                  )),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Products',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View all...',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Colors.red),
                    ),
                  ),
                ]),
          ),
          Container(
              height: 285,
              margin: EdgeInsets.symmetric(horizontal: 3),
              width: double.infinity,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (BuildContext ctx, int idx) {
                    return PopularProducts();
                  })),
        ],
      ),
    );
  }
}
