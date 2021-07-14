import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';
import 'package:udemy_course/consts/app_colors.dart';
import 'package:udemy_course/providers/app_theme_provider.dart';
import 'package:udemy_course/providers/user_provider.dart';
import 'package:udemy_course/screens/cart.dart';
import 'package:udemy_course/screens/wishlist.dart';
import 'package:udemy_course/widgets/app_dialogs.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late ScrollController _scrollController;
  var top = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<AppThemeProvider>(context);
    final _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        body: Center(
            child: CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
          elevation: 4,
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            top = constraints.biggest.height;
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.starterColor, AppColors.endColor],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                centerTitle: true,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: top <= 110.0 ? 1.0 : 0,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                            height: kToolbarHeight / 1.8,
                            width: kToolbarHeight / 1.8,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 1.0,
                                ),
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Guest',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                background: Image(
                  image: NetworkImage(
                      'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            );
          }),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'User Bag',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  )),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              userListTile(context, 'Wishlist', '', Icons.wifi_sharp,
                  Icons.chevron_right_rounded, () {
                Navigator.pushNamed(context, WishlistScreen.routeName);
              }),
              userListTile(context, 'Cart', '', Icons.wifi_sharp,
                  Icons.chevron_right_rounded, () {
                Navigator.pushNamed(context, CartScreen.routeName);
              }),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'User Info',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              userListTile(context, 'Email', _userProvider.userLoggedin.email,
                  Icons.email, null, () {}),
              userListTile(
                  context,
                  'Phone',
                  _userProvider.userLoggedin.phoneNumber,
                  Icons.phone,
                  null,
                  () {}),
              userListTile(context, 'Shipping', 'subt', Icons.local_shipping,
                  null, () {}),
              userListTile(
                  context,
                  'Joined date',
                  _userProvider.userLoggedin.joinedAt.toString(),
                  Icons.watch_later,
                  null,
                  () {}),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'User Settings',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              ListTileSwitch(
                value: themeChange.appTheme,
                leading: const Icon(Icons.access_alarms),
                onChanged: (value) {
                  setState(() {
                    themeChange.appTheme = value;
                  });
                },
                visualDensity: VisualDensity.comfortable,
                switchType: SwitchType.cupertino,
                switchActiveColor: Colors.indigo,
                title: const Text(
                  'Dark Theme',
                ),
              ),
              userListTile(
                context,
                'Logout',
                '',
                Icons.exit_to_app_rounded,
                null,
                () async => await AppDialogs.showAlert(
                    context,
                    'Sign Out',
                    'Do you really want to sign out?',
                    () {},
                    () async => await FirebaseAuth.instance.signOut()),
              )
            ],
          ),
        ),
      ],
    )));
  }

  Widget userListTile(BuildContext context, String title, String subtitle,
      IconData icon, IconData? trailingIcon, VoidCallback fnc) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap: fnc,
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(icon),
          trailing: trailingIcon == null ? null : Icon(trailingIcon),
        ),
      ),
    );
  }
}
