import 'package:flutter/material.dart';
import '/consts/app_icons.dart';

class AppDialogs {
  static Future<void> showAlert(BuildContext context, String title,
      String subtitle, VoidCallback fncCancel, VoidCallback fncOk) {
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Icon(AppIcons.alert)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title),
                )
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () {
                    fncCancel();
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    fncOk();
                    Navigator.pop(context);
                  },
                  child: Text('Ok')),
            ],
          );
        });
  }

  static Future<void> showError(
      BuildContext context, String title, String subtitle, VoidCallback fncOk) {
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Icon(AppIcons.error)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title),
                )
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () {
                    fncOk();
                    Navigator.pop(context);
                  },
                  child: Text('Ok')),
            ],
          );
        });
  }
}
