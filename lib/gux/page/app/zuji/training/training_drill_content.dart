
import 'package:flutter/material.dart';
import 'training_drill_detail.dart';
import 'training_drill_summary.dart';
import 'training_drill_base.dart';
import 'training_drill_diagram.dart';
import 'training_drill_intensity.dart';
import 'training_drill_target.dart';

import '/styles.dart' as styles;

class TrainingDrillContent extends StatefulWidget {

  final Map trainingDrill;

  final double width;

  const TrainingDrillContent(this.trainingDrill, {
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TrainingDrillContentState();

}

class TrainingDrillContentState extends State<TrainingDrillContent> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TrainingDrillSummary(widget.trainingDrill, width: widget.width),
          SizedBox(height: styles.padding,),
          TrainingDrillBase(widget.trainingDrill, width: widget.width),
          SizedBox(height: styles.padding,),
          TrainingDrillDetail(widget.trainingDrill, width: widget.width,),
          SizedBox(height: styles.padding,),
          TrainingDrillDiagram(widget.trainingDrill, width: widget.width,),
          SizedBox(height: styles.padding,),
          TrainingDrillIntensity(widget.trainingDrill, width: widget.width,),
          SizedBox(height: styles.padding,),
          TrainingDrillTarget(widget.trainingDrill, width: widget.width,),
        ],
      ),
    );
  }

}

