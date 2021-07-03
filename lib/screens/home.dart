import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:udemy_course/widgets/front_layer.dart';
import '/consts/app_colors.dart';
import '/widgets/back_layer.dart';
import '/widgets/front_layer.dart';

class HomeScreen extends StatelessWidget {
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
          child: BackLayerMenu(),
        ),
        frontLayer: FrontLayer(),
      ),
    );
  }
}
