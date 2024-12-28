
import 'package:flutter/cupertino.dart';

class Loading extends StatelessWidget {

  final double size;

  Loading({
    this.size = 64,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset('asset/icon/loading.gif',
      width: size,
      height: size,
    );
  }

}