import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_theme_provider.dart';
import 'providers/favorite_provider.dart';
import 'screens/auth/login.dart';
import 'screens/auth/sign_up.dart';
import 'screens/feeds.dart';
import 'bottom_bar.dart';
import 'consts/app_styles.dart';
import 'providers/cart_provider.dart';
import 'providers/products_provider.dart';
import 'screens/brands_navigation_rail.dart';
import 'screens/cart.dart';
import 'screens/categories_feeds.dart';
import 'screens/landing_page.dart';
import 'screens/product_detail.dart';
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
          }),
          ChangeNotifierProvider(create: (_) => ProductsProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => FavoritesProvider())
        ],
        child: Consumer<AppThemeProvider>(builder: (context, themeData, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: AppStyles.themeData(themeChangeProvider.appTheme, context),
            home: LandingPage(),
            routes: {
              //'/': (ctx) => BottomBarScreen(), //LandingPage(),
              BrandNavigationRailScreen.routeName: (ctx) =>
                  BrandNavigationRailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              FeedsScreen.routeName: (ctx) => FeedsScreen(showTitle: true),
              WishlistScreen.routeName: (ctx) => WishlistScreen(),
              ProductDetail.routeName: (ctx) => ProductDetail(),
              CategoriesFeedsScreen.routeName: (ctx) => CategoriesFeedsScreen(),
              LoginScreen.routeName: (ctx) => LoginScreen(),
              SignUpScreen.routeName: (ctx) => SignUpScreen(),
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
