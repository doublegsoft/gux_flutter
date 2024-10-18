import 'package:flutter/material.dart';
import 'package:gux/gux/page/app/zuji/training/training_drill_content.dart';
import 'package:gux/gux/page/app/zuji/training/training_plan_summary.dart';
import 'package:gux/widget/gx_sliver_appbard_delegate.dart';
import '/widget/gx_tab_item.dart';

import '/styles.dart' as styles;



class ZujiFootballApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => ZujiFootballAppState();

}

class ZujiFootballAppState extends State<ZujiFootballApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset('asset/image/logo/zuji.png', width: 32, height: 32, fit: BoxFit.cover,),
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
            delegate: GXSliverAppBarDelegate(
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