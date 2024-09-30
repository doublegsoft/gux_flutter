
import 'package:flutter/material.dart';
import '/styles.dart' as styles;

class TrainingPlanSummary extends StatefulWidget {

  final Map trainingPlan;

  const TrainingPlanSummary(this.trainingPlan, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TrainingPlanSummaryState();

}

class TrainingPlanSummaryState extends State<TrainingPlanSummary> {

  late Map _trainingPlan;

  @override
  void initState() {
    super.initState();
    _trainingPlan = widget.trainingPlan;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: styles.screenWidth - styles.padding * 2,
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
            height: 240,
            child: Image.network('',
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  child: Center(
                    child: Text('未设置图片', style: TextStyle(color: styles.colorTextPlaceholder)),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Text(_trainingPlan['title']??'这里是训练项标题', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 10),
          Text(_trainingPlan['summary']??'足球专项战术训练课程旨在提高球员对比赛的理解能力和决策能力。', style: TextStyle(fontSize: 14,)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                child: Image.network(_trainingPlan['avatar']??'',
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
                  Text(_trainingPlan['createBy']??'创建者', style: TextStyle(fontSize: 12,)),
                  Text(_trainingPlan['createBy']??'创建日期', style: TextStyle(fontSize: 12,)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

}
