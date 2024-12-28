
import 'package:flutter/material.dart';

class MoreLink extends StatelessWidget {

  final String label;

  final WidgetBuilder builder;

  MoreLink({
    required this.label,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(label,
        style: TextStyle(
          fontSize: 13,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: builder));
      },
    );
  }

}