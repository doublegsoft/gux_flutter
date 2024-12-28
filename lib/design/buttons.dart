
import 'package:flutter/material.dart';

import 'styles.dart' as styles;

class RoundedButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  late Color? backgroundColor;
  late Color? foregroundColor;

  RoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 48,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key) {
    if (backgroundColor == null) {
      backgroundColor = styles.colorPrimary;
    }
    if (foregroundColor == null) {
      foregroundColor = styles.colorTextInverse;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: const StadiumBorder(), // Rounded shape
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust padding as needed
        ),
        child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,),),
      ),
    );
  }
}

class CloseIconButton extends StatelessWidget {

  Color? color;

  CloseIconButton({
    VoidCallback? didTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Icon(
          Icons.arrow_back_ios_new_outlined,
          size: 22,
          weight: 3,
          color: color??null,
        ),
      ),
    );
  }
}

class ClearIconButton extends StatelessWidget {

  VoidCallback? didTap;

  ClearIconButton({
    this.didTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (didTap != null) {
          didTap!();
        } else {
          Navigator.pop(context);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Icon(
          Icons.close,
          color: styles.colorError,
          size: 28,
        ),
      ),
    );
  }
}

class ConfirmIconButton extends StatelessWidget {

  VoidCallback? didTap;

  ConfirmIconButton({
    this.didTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (didTap != null) {
          didTap!();
        } else {
          Navigator.pop(context);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Icon(
          Icons.check,
          color: styles.colorPrimary,
          size: 28,
          weight: 100,
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {

  final VoidCallback? onPress;

  final Icon icon;

  Color? color;

  CircleButton({
    required this.icon,
    this.onPress,
    this.color,
  }) {
    if (this.color == null) {
      this.color = styles.colorPrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onPress != null ? this.onPress : (){},
      child: this.icon,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
        backgroundColor: color,
      ),
    );
  }

}
