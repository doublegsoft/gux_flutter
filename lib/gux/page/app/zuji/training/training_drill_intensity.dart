
import 'package:flutter/material.dart';
import '/styles.dart' as styles;


class TrainingDrillIntensity extends StatefulWidget {

  final Map trainingDrill;

  final double width;

  const TrainingDrillIntensity(this.trainingDrill, {
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TrainingDrillIntensityState();

}

class TrainingDrillIntensityState extends State<TrainingDrillIntensity> {

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
          Text('训练强度', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          SizedBox(height: styles.padding),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                colors: const [
                  Color(0xFF1381D7),
                  Color(0xFF1DA4BA),
                  Color(0xFF7DD067),
                  Color(0xFFEBD20A),
                  Color(0xFFE9952C),
                  Color(0xFFE81157),
                  Color(0xFFE70C5A),
                ],
                stops: [0, 0.17, 0.34, 0.51, 0.68, 0.85, 1],
              ),
            ),
            child: const SizedBox(height: 20),
          ),
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('低'), Text('高'),
                ],
              ),
              Positioned(
                left: 50,
                top: 0,
                child: Text('训练强度'),
              ),
            ],
          ),
        ],
      ),
    );
  }

}

