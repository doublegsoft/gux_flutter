
import 'package:flutter/material.dart';
import '/styles.dart' as styles;

class TrainingDrillDiagram extends StatefulWidget {

  final Map trainingDrill;

  final double width;

  const TrainingDrillDiagram(this.trainingDrill, {
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TrainingDrillDiagramState();

}

class TrainingDrillDiagramState extends State<TrainingDrillDiagram> {

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
          Text('示意图', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          SizedBox(height: 10),
          Container(
            height: 200,
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
        ],
      ),
    );
  }

}

