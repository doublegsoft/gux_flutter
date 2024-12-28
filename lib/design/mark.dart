import 'package:flutter/material.dart';

enum MarkPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class Mark extends StatelessWidget {
  final Widget child;
  final String? badgeText;
  final Color badgeColor;
  final MarkPosition badgePosition;
  final double badgeRadius;
  final EdgeInsets? badgePadding;

  const Mark({
    Key? key,
    required this.child,
    this.badgeText,
    this.badgeColor = Colors.red,
    this.badgePosition = MarkPosition.topRight,
    this.badgeRadius = 10.0,
    this.badgePadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: _getAlignment(),
      children: [
        child,
        if (badgeText != null && badgeText!.isNotEmpty)
          _buildBadge(),
      ],
    );
  }

  Alignment _getAlignment() {
    switch (badgePosition) {
      case MarkPosition.topLeft:
        return Alignment.topLeft;
      case MarkPosition.topRight:
        return Alignment.topRight;
      case MarkPosition.bottomLeft:
        return Alignment.bottomLeft;
      case MarkPosition.bottomRight:
        return Alignment.bottomRight;
      default:
        return Alignment.topRight;
    }
  }

  Widget _buildBadge() {
    return Container(
      padding: badgePadding ?? EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(badgeRadius),
      ),
      child: Text(
        badgeText!,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}