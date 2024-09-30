
import 'package:flutter/material.dart';
import '/styles.dart' as styles;

const Color COLOR_LABEL_BACKGROUND = Color(0xfff7f2f7);

const Color COLOR_LABEL_FOREGROUND = Color(0xff333333);

const Color COLOR_TEXT_BACKGROUND = Color(0xfffafafa);

const Color COLOR_TEXT_FOREGROUND = Color(0xff320f32);

class TrainingDrillBase extends StatefulWidget {

  final Map trainingDrill;

  final double width;

  const TrainingDrillBase(this.trainingDrill, {
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TrainingDrillBaseState();

}

class TrainingDrillBaseState extends State<TrainingDrillBase> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 181,
      width: widget.width,
      padding: EdgeInsets.all(styles.padding),
      decoration: BoxDecoration(
        color: styles.colorSurface,
        borderRadius: BorderRadius.circular(10), // 圆角半径
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('基本信息', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          SizedBox(height: 10),
          Row(
            children: [
              _buildLabelAndText('训练主题', ''),
              SizedBox(width: styles.padding * 2),
              _buildLabelAndText('训练难度', ''),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              _buildLabelAndText('适合年龄', ''),
              SizedBox(width: styles.padding * 2),
              _buildLabelAndText('训练时长', ''),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              _buildLabelAndText('适合人数', ''),
              SizedBox(width: styles.padding * 2),
              _buildLabelAndText('场地大小', ''),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLabelAndText(String label, String? text) {
    final width = (widget.width - styles.padding * 6) / 2;
    final halfWidth = width / 2;
    return Container(
      height: 32,
      width: width,
      // decoration: BoxDecoration(
      //   color: Colors.blue,
      //   borderRadius: BorderRadius.circular(10), // 圆角半径
      // ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 6, left: 6),
            child: Text(label, style: TextStyle(fontSize: 14)),
            height: 32,
            width: halfWidth,
            decoration: BoxDecoration(
              color: COLOR_LABEL_BACKGROUND,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            ),
          ),
          Container(
            height: 32,
            width: halfWidth,
            decoration: BoxDecoration(
              color: COLOR_TEXT_BACKGROUND,
              borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
            ),
            child: Text(text??''),
          ),
        ],
      ),
    );
  }

}

