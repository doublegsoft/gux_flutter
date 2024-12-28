import 'package:flutter/material.dart';

import 'buttons.dart';
import 'styles.dart' as styles;

void success({
  required BuildContext context,
  required String title,
  String? description,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Adjust the radius as needed
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min, // Important for proper sizing
          children: <Widget>[
            Image.asset('asset/image/common/happy.png', height: 96, width: 96,),
            const SizedBox(height: 16),
            Text(title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description??'',
              style: TextStyle(color: Colors.grey), // Use a lighter color for subtext
            ),
            const SizedBox(height: 24),  // Add spacing above the button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: styles.colorSuccess,
                foregroundColor: styles.colorTextInverse,
                minimumSize: const Size.fromHeight(40), // Set button height
              ),
              child: const Text('我知道了'),
            ),
          ],
        ),
      );
    },
  );
}

void error({
  required BuildContext context,
  required String title,
  String? description,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Adjust the radius as needed
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min, // Important for proper sizing
          children: <Widget>[
            Image.asset('asset/image/common/sad.png', height: 96, width: 96,),
            const SizedBox(height: 16),
            Text(title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description??'',
              style: TextStyle(color: Colors.grey), // Use a lighter color for subtext
            ),
            const SizedBox(height: 24),  // Add spacing above the button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: styles.colorSuccess,
                foregroundColor: styles.colorTextInverse,
                minimumSize: const Size.fromHeight(40), // Set button height
              ),
              child: const Text('我知道了'),
            ),
          ],
        ),
      );
    },
  );
}

void confirm({
  required BuildContext context,
  required String title,
  String? description,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(description??'', style: TextStyle(fontSize: 16)),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedButton(
                text: '取消',
                width: 120,
                backgroundColor: styles.colorTextPlaceholder,
                onPressed: () {
                  if (onCancel != null) {
                    onCancel();
                  } else {
                    Navigator.of(context).pop(false);
                  }
                },
              ),
              SizedBox(width: 10,),
              RoundedButton(
                text: '确定',
                width: 120,
                backgroundColor: styles.colorError,
                onPressed: () {
                  if (onConfirm != null) {
                    onConfirm();
                  } else {
                    Navigator.of(context).pop(true);
                  }
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}