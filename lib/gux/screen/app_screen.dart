import 'package:flutter/material.dart';

class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => UserScreen()),
          // );
        },
        child: Text('this is app screen'),
      ),
    );
  }
}
