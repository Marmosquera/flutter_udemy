import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import '/consts/app_colors.dart';
import '/widgets/home_back_layer.dart';
import '/widgets/home_front_layer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackdropScaffold(
        frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        headerHeight: MediaQuery.of(context).size.height * 0.25,
        appBar: BackdropAppBar(
          title: Text("Home"),
          leading: BackdropToggleButton(
            icon: AnimatedIcons.home_menu,
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.starterColor, AppColors.endColor])),
          ),
          actions: <Widget>[
            BackdropToggleButton(
              icon: AnimatedIcons.home_menu,
            )
          ],
        ),
        backLayer: Center(
          child: HomeBackLayerMenu(),
        ),
        frontLayer: HomeFrontLayer(),
      ),
    );
  }
}
