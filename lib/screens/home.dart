import 'package:backdrop/backdrop.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List _carouselIcons = [
    'assets/images/carousel1.png',
    'assets/images/carousel2.jpeg',
    'assets/images/carousel3.jpg',
    'assets/images/carousel4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backdrop Demo',
      home: BackdropScaffold(
        appBar: BackdropAppBar(
          title: Text("Home"),
          leading: BackdropToggleButton(
            icon: AnimatedIcons.home_menu,
          ),
          actions: <Widget>[
            BackdropToggleButton(
              icon: AnimatedIcons.home_menu,
            )
          ],
        ),
        backLayer: Center(
          child: Text("Back Layer"),
        ),
        subHeader: BackdropSubHeader(
          title: Text("Sub Header"),
        ),
        frontLayer: Container(
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
            images: List.generate(_carouselIcons.length, (index) => Image(image: ExactAssetImage(_carouselIcons[index]))
          ),
        ),
      ),
    );
  }
}
