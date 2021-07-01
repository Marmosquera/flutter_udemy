import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          userListTile(context, 'Email', 'subt', Icons.email),
          userListTile(context, 'Phone', 'subt', Icons.phone),
          userListTile(context, 'Shipping', 'subt', Icons.local_shipping),
          userListTile(context, 'Joined date', 'date', Icons.watch_later),
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
            value: _value,
            leading: const Icon(Icons.access_alarms),
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
            visualDensity: VisualDensity.comfortable,
            switchType: SwitchType.cupertino,
            switchActiveColor: Colors.indigo,
            title: const Text(
              'Dark Theme',
            ),
          ),
          userListTile(context, 'Logout', '', Icons.exit_to_app_rounded),
        ],
      ),
    ));
  }

  Widget userListTile(
      BuildContext context, String title, String subtitle, IconData icon) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap: () {},
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(icon),
        ),
      ),
    );
  }
}
