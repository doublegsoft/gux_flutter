
import 'package:flutter/material.dart';
import 'training_drill_content.dart';
import 'training_plan_summary.dart';

import '/styles.dart' as styles;

class TrainingPlanContent extends StatefulWidget {

  final Map trainingPlan;

  const TrainingPlanContent(this.trainingPlan, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TrainingPlanContentState();

}

class TrainingPlanContentState extends State<TrainingPlanContent> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TrainingPlanSummary({}),
          SizedBox(height: styles.padding,),
          TrainingDrillContent({}, width: styles.screenWidth,),
        ],
      ),
    );
  }

}

