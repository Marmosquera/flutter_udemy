import 'package:flutter/material.dart';

import '/screens/cart.dart';
import '/screens/feeds.dart';
import '/screens/home.dart';
import '/screens/search.dart';
import '/screens/user.dart';
import 'consts/app_icons.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List<_PageListItem> _pages = [];
  int _selectedIndex = 4;

  @override
  void initState() {
    _pages = [
      _PageListItem(page: HomeScreen(), title: 'Home Screen'),
      _PageListItem(page: FeedsScreen(), title: 'Feed Screen'),
      _PageListItem(page: SearchScreen(), title: 'Search Screen'),
      _PageListItem(page: CartScreen(), title: 'Cart Screen'),
      _PageListItem(page: UserScreen(), title: 'User Screen'),
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex].page,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration:
              BoxDecoration(border: Border(top: BorderSide(width: 0.5))),
          child: BottomNavigationBar(
            onTap: _selectedPage,
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            selectedItemColor: Colors.purple,
            currentIndex: _selectedIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(AppIcons.home),
                tooltip: 'Home',
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(AppIcons.rss),
                tooltip: 'Feeds',
                label: 'Feeds',
              ),
              BottomNavigationBarItem(
                activeIcon: null,
                icon: Icon(null),
                tooltip: 'Search',
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(AppIcons.cart),
                tooltip: 'Cart',
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(AppIcons.user),
                tooltip: 'User',
                label: 'User',
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          tooltip: 'Search',
          elevation: 5,
          child: (Icon(AppIcons.search)),
          onPressed: () => _selectedPage(2)),
    );
  }
}

class _PageListItem {
  final String title;
  final Widget page;

  const _PageListItem({required this.page, required this.title});
}
