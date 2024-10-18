
import 'package:flutter/material.dart';
import '/styles.dart' as styles;

class TrainingDrillSummary extends StatefulWidget {

  final Map trainingDrill;

  final double width;

  const TrainingDrillSummary(this.trainingDrill, {
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TrainingDrillSummaryState();

}

class TrainingDrillSummaryState extends State<TrainingDrillSummary> {

  late Map _trainingDrill;

  @override
  void initState() {
    super.initState();
    _trainingDrill = widget.trainingDrill;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: EdgeInsets.all(styles.padding),
      decoration: BoxDecoration(
        color: styles.colorSurface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: styles.colorSuccessLight,
              borderRadius: BorderRadius.circular(4), // 圆角半径
            ),
            child: Text('训练项', style: TextStyle(fontSize: 12, color: styles.colorSuccess))
          ),
          SizedBox(height: 10),
          Text(_trainingDrill['title']??'这里是训练项标题', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 10),
          Text(_trainingDrill['summary']??'Football specific tactical training sessions are aimed at enhancing players'' understanding of the game and their decision-making abilities. 足球专项战术训练课程旨在提高球员对比赛的理解能力和决策能力。', style: TextStyle(fontSize: 14,)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                child: Image.network(_trainingDrill['avatar']??'',
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('asset/image/common/avatar.png');
                  },
                ),
              ),
              SizedBox(width: styles.padding),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_trainingDrill['createBy']??'创建者', style: TextStyle(fontSize: 12,)),
                  Text(_trainingDrill['createBy']??'创建日期', style: TextStyle(fontSize: 12,)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

}
