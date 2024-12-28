import 'package:flutter/material.dart';
import 'package:gux/gux/page/page/article_page.dart';
import 'package:gux/gux/page/page/criteria_page.dart';
import 'package:gux/gux/page/page/doctor_profile_page.dart';
import 'package:gux/gux/page/page/schedule_page.dart';
import 'package:gux/gux/page/page/score_page.dart';

import '../../design/styles.dart' as styles;

class PageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('页面'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildPage(context, '医生概貌', () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => DoctorProfilePage()),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: _buildPage(context, '足球比分', () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => ScorePage()),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: _buildPage(context, '文章评论', () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => ArticlePage()),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: _buildPage(context, '日程安排', () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => SchedulePage()),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: _buildPage(context, '查询页面', () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => CriteriaPage()),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context, String title, Function() onTap) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: styles.padding / 2, horizontal: styles.padding),
          title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          onTap: onTap,
        ),
        Container(
          color: styles.colorDivider,
          child: SizedBox(
            height: 1,
            width: styles.screenWidth * 0.88,
          ),
        ),
      ],
    );
  }
}
