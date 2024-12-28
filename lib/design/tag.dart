import 'package:flutter/material.dart';

import 'styles.dart' as styles;

class Tag extends StatelessWidget {
  final String text;
  Color? backgroundColor;
  Color? foregroundColor;
  final VoidCallback? onRemoved;
  final double borderRadius;
  final EdgeInsets? padding;

  Tag({
    Key? key,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.onRemoved,
    this.borderRadius = 8.0,
    this.padding,
  }) : super(key: key) {
    if (backgroundColor == null) {
      backgroundColor = styles.colorInfoLight;
    }
    if (foregroundColor == null) {
      foregroundColor = styles.colorInfo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(color: foregroundColor),
          ),
          if (onRemoved != null)
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: GestureDetector(
                onTap: onRemoved,
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
            )
        ],
      ),
    );
  }
}