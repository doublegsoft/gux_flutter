
import 'package:flutter/material.dart';

class GXDialog {

  GXDialog(this.navigatorKey);

  final GlobalKey<NavigatorState> navigatorKey;

  Future<bool?> showYesNoDialog(String title, String message) =>
    showDialog<bool>(
      context: navigatorKey.currentState!.context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('是'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          TextButton(
            child: const Text('否'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      ),
    );
}