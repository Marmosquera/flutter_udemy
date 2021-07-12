import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_course/screens/user.dart';
import 'package:udemy_course/screens/user_state.dart';

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
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    DesktopWindow.setWindowSize(Size(400, 700));
    //DesktopWindow.setMinWindowSize(Size(400, 400));
    //DesktopWindow.setMaxWindowSize(Size(800, 800));
  }
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

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error occured'),
                ),
              ),
            );
          }

          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => themeChangeProvider),
                ChangeNotifierProvider(create: (_) => ProductsProvider()),
                ChangeNotifierProvider(create: (_) => CartProvider()),
                ChangeNotifierProvider(create: (_) => FavoritesProvider())
              ],
              child: Consumer<AppThemeProvider>(
                  builder: (context, themeData, child) {
                return MaterialApp(
                  title: 'Flutter Demo',
                  theme: AppStyles.themeData(
                      themeChangeProvider.appTheme, context),
                  home: UserState(),
                  routes: {
                    //'/': (ctx) => BottomBarScreen(), //LandingPage(),
                    BrandNavigationRailScreen.routeName: (ctx) =>
                        BrandNavigationRailScreen(),
                    CartScreen.routeName: (ctx) => CartScreen(),
                    FeedsScreen.routeName: (ctx) =>
                        FeedsScreen(showTitle: true),
                    WishlistScreen.routeName: (ctx) => WishlistScreen(),
                    ProductDetail.routeName: (ctx) => ProductDetail(),
                    CategoriesFeedsScreen.routeName: (ctx) =>
                        CategoriesFeedsScreen(),
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                    SignUpScreen.routeName: (ctx) => SignUpScreen(),
                    BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
                    LandingPage.routeName: (ctx) => LandingPage(),
                    //UploadProductForm.routeName: (ctx) => UploadProductForm(),
                  },
                );
              }));
        });
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.appTheme =
        await themeChangeProvider.appThemeRepository.getTheme();
  }
}
