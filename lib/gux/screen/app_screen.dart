import 'package:flutter/material.dart';
import 'package:gux/styles.dart';

import '../app/zuji/training/training_drill_content.dart';
import '../app/zuji/training/training_plan_content.dart';

import '../app/zuji/training/training_plan_summary.dart';
import '/styles.dart' as styles;

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('👣'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: styles.padding, right: styles.padding, top: styles.padding),
              child: TrainingPlanSummary({}),
            ),
          ),
          SliverPersistentHeader(
            pinned: true, // 设置为 true 使标题栏固定在底部
            delegate: _SliverAppBarDelegate(
              minHeight: 32 + styles.padding * 2,
              maxHeight: 32 + styles.padding * 2,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: styles.padding),
                height: 32 + styles.padding * 2,
                color: Color(0xffffffff),
                width: styles.screenWidth - styles.padding * 2,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: styles.padding),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(41),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      width: 82,
                      height: 32,
                      child: Center(child: Text('热身部分')),
                    ),
                    SizedBox(width: styles.padding),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(41),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      width: 82,
                      height: 32,
                      child: Center(child: Text('基础部分')),
                    ),
                    SizedBox(width: styles.padding),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(41),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      width: 82,
                      height: 32,
                      child: Center(child: Text('技术部分')),
                    ),
                    SizedBox(width: styles.padding),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(41),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      width: 82,
                      height: 32,
                      child: Center(child: Text('比赛部分')),
                    ),
                    SizedBox(width: styles.padding),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(41),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      width: 82,
                      height: 32,
                      child: Center(child: Text('放松部分')),
                    ),
                    SizedBox(width: styles.padding),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: styles.padding, right: styles.padding, bottom: styles.padding),
              child: TrainingDrillContent({}, width: styles.screenWidth,),
            ),
          ),
        ],
      ),
    );
  }
}
