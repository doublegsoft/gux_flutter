import 'package:flutter/material.dart';

import 'avatar.dart';

class AvatarData {
  final String id;
  final String url;

  AvatarData({
    required this.id,
    required this.url,
  });
}

class Avatars extends StatelessWidget {

  final double size;
  final List<AvatarData> avatars;
  final bool circular;

  Avatars({
    this.avatars = const <AvatarData>[],
    this.size = 48,
    this.circular = true,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = avatars.length - 1; i >= 0; i--) {
      widgets.add(Positioned(
        left: i * (size - 20),
        child: Avatar(url: avatars[i].url, size: size,),
      ));
    }
    return Container(
      height: size,
      child: Stack(
        children: widgets,
      ),
    );
  }

}