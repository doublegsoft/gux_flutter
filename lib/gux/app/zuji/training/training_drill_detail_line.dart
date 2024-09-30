
import 'package:flutter/material.dart';
import '/styles.dart' as styles;

const Color COLOR_LABEL_BACKGROUND = Color(0xfff7f2f7);

const Color COLOR_LABEL_FOREGROUND = Color(0xff320F32);

class TrainingDrillDetailLine extends StatefulWidget {

  final int index;

  final String description;

  const TrainingDrillDetailLine({
    Key? key,
    required this.index,
    required this.description,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TrainingDrillDetailLineState();

}

class TrainingDrillDetailLineState extends State<TrainingDrillDetailLine> {

  final TextStyle textStyle = TextStyle(fontSize: 12);

  double _height = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTextHeight();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xfffafafa),
                ),
                child: Center(child: Text('${widget.index}', style: TextStyle(fontWeight: FontWeight.w600)),),
              ),
              Container(
                width: 2,
                height: _height + styles.padding,
                decoration: BoxDecoration(
                  color: Color(0xfffafafa),
                ),
              ),
            ],
          ),
          SizedBox(width: styles.padding * 1.5),
          Expanded(
            child: Container(
              color: Color(0xfffafafa),
              padding: EdgeInsets.symmetric(horizontal: styles.padding, vertical: 2),
              child: Text(widget.description, style: textStyle),
            ),
          ),
        ],
      ),
    );
  }

  void _calculateTextHeight() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: widget.description, style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    setState(() {
      _height = textPainter.height;
    });
  }
}

