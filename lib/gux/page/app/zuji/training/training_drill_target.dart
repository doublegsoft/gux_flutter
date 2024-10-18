
import 'package:flutter/material.dart';
import '/styles.dart' as styles;

const Color COLOR_LABEL_BACKGROUND = Color(0xfff7f2f7);

const Color COLOR_LABEL_FOREGROUND = Color(0xff320F32);

class TrainingDrillTarget extends StatefulWidget {

  final Map trainingDrill;

  final double width;

  const TrainingDrillTarget(this.trainingDrill, {
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TrainingDrillTargetState();

}

class TrainingDrillTargetState extends State<TrainingDrillTarget> {

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text('针对属性', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          SizedBox(height: 10),
          ..._buildSection('进攻', ['射门','传跑','头球','任意球','点球']),
          SizedBox(height: 10),
          ..._buildSection('防守', ['抢断','滑铲','身体对抗']),
        ],
      ),
    );
  }

  List<Widget> _buildSection(String title, List<String> labels) {
    List<Widget> ret = [];
    ret.add(Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)));
    ret.add(Wrap(
      children: labels.map((item) {
        return _buildTag(item);
      }).toList(),
    ));
    return ret;
  }

  Widget _buildTag(String label) {
    return Container(
      decoration: BoxDecoration(
        color: COLOR_LABEL_BACKGROUND,
        borderRadius: BorderRadius.circular(4), // 圆角半径
      ),
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(styles.padding / 2),
      child: Text(label, style: TextStyle(fontSize: 14, color: COLOR_LABEL_FOREGROUND)),
    );
  }
}

