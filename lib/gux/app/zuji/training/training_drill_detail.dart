
import 'package:flutter/material.dart';
import 'package:gux/gux/app/zuji/training/training_drill_detail_line.dart';
import '/styles.dart' as styles;

const Color COLOR_LABEL_BACKGROUND = Color(0xfff7f2f7);

const Color COLOR_LABEL_FOREGROUND = Color(0xff320F32);

class TrainingDrillDetail extends StatefulWidget {

  final Map trainingDrill;

  final double width;

  const TrainingDrillDetail(this.trainingDrill, {
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TrainingDrillDetailState();

}

class TrainingDrillDetailState extends State<TrainingDrillDetail> {

  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      width: widget.width - styles.padding * 2,
      padding: EdgeInsets.all(styles.padding),
      decoration: BoxDecoration(
        color: styles.colorSurface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildSection('组织方法', ['射门','传跑','头球','任意球','点球']),
          SizedBox(height: 10),
          ..._buildSection('教学控制', ['抢断','滑铲','身体对抗']),
          SizedBox(height: 10),
          ..._buildSection('教学目标', ['抢断','滑铲','身体对抗']),
          SizedBox(height: 10),
          ..._buildSection('关键点', ['抢断','滑铲','身体对抗']),
        ],
      ),
    );
  }

  List<Widget> _buildSection(String title, List<String> labels) {
    List<Widget> ret = [];
    List<Widget> children = [];
    for (int i = 0; i < labels.length; i++) {
      // children.add(_buildLine(i, labels[i]));
      children.add(TrainingDrillDetailLine(index: i+1, description: labels[i]));
    }
    ret.add(Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)));
    ret.add(SizedBox(height: styles.padding));
    ret.add(Wrap(
      children: children,
    ));
    return ret;
  }

  Widget _buildLine(int index, String label) {
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
                child: Center(child: Text('${index+1}', style: TextStyle(fontWeight: FontWeight.w600)),),
              ),
              Container(
                width: 2,
                height: 75,
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
              child: Text('指提高球员心理素质的训练，例如自信心、注意力、意志力、团队合作等。'),
            ),
          ),
        ],
      ),
    );
  }
}

