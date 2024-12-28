import 'dart:ui';

import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  
  final double size;
  final String? url;
  final String? name;
  final bool circular;
  final Color color;

  Avatar({
    this.name,
    this.url,
    this.size = 48,
    this.circular = true,
    this.color = Colors.transparent,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: circular ? BoxShape.circle : BoxShape.rectangle,
        color: color,
      ),
      child:  ClipRRect(
        borderRadius: circular ? BorderRadius.circular(size / 2) : BorderRadius.zero,
        child: _buildAvatarContent(),
      ),
    );
  }

  Widget _buildAvatarContent() {
    if (url != null && url!.isNotEmpty) {
      return Image.network(url!,
        fit: BoxFit.cover,
        width: size,
        height: size,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
          return _buildPlaceholder();
        },
      );
    } else if (name != null) {
      String first = name!.substring(0, 1);
      return _buildTextAvatar(first);
    } else {
      return _buildPlaceholder();
    }
  }

  Widget _buildTextAvatar(String letter) {
    return Center(
      child: Text(letter,
        style: TextStyle(fontSize: size * 2 / 4, fontWeight: FontWeight.w600,),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Image.asset('asset/image/common/avatar.png',
      height: size,
      width: size,
      fit: BoxFit.cover,
    );
  }
}