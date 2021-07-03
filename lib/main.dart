import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_course/providers/app_theme_provider.dart';
import 'package:udemy_course/screens/feeds.dart';

import 'bottom_bar.dart';
import 'consts/app_styles.dart';
import 'screens/brands_navigation_rail.dart';
import 'screens/cart.dart';
import 'screens/wishlist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppThemeProvider themeChangeProvider = AppThemeProvider();

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return themeChangeProvider;
          })
        ],
        child: Consumer<AppThemeProvider>(builder: (context, themeData, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: AppStyles.themeData(themeChangeProvider.appTheme, context),
            //home: BottomBarScreen(),
            routes: {
              '/': (ctx) => BottomBarScreen(), //LandingPage(),
              BrandNavigationRailScreen.routeName: (ctx) =>
                  BrandNavigationRailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              FeedsScreen.routeName: (ctx) => FeedsScreen(),
              WishlistScreen.routeName: (ctx) => WishlistScreen(),
              //ProductDetails.routeName: (ctx) => ProductDetails(),
              //CategoriesFeedsScreen.routeName: (ctx) =>                        CategoriesFeedsScreen(),
              //LoginScreen.routeName: (ctx) => LoginScreen(),
              //SignUpScreen.routeName: (ctx) => SignUpScreen(),
              BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
              //UploadProductForm.routeName: (ctx) => UploadProductForm(),
            },
          );
        }));
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.appTheme =
        await themeChangeProvider.appThemeRepository.getTheme();
  }
}
