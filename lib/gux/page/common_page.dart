/*
** ──────────────────────────────────────────────────
** ─██████████████─██████──██████─████████──████████─
** ─██░░░░░░░░░░██─██░░██──██░░██─██░░░░██──██░░░░██─
** ─██░░██████████─██░░██──██░░██─████░░██──██░░████─
** ─██░░██─────────██░░██──██░░██───██░░░░██░░░░██───
** ─██░░██─────────██░░██──██░░██───████░░░░░░████───
** ─██░░██──██████─██░░██──██░░██─────██░░░░░░██─────
** ─██░░██──██░░██─██░░██──██░░██───████░░░░░░████───
** ─██░░██──██░░██─██░░██──██░░██───██░░░░██░░░░██───
** ─██░░██████░░██─██░░██████░░██─████░░██──██░░████─
** ─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░██──██░░░░██─
** ─██████████████─██████████████─████████──████████─
** ──────────────────────────────────────────────────
*/
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:gux/widget/gx_grid_view.dart';
import 'package:gux/widget/gx_widget_size.dart';

import '../common/congratulation.dart';
import '../common/no_internet_page.dart';
import '../common/thank_you_page.dart';
import '../common/under_construction_page.dart';
import '/gux/common/article_page.dart';
import '/gux/common/failure_page.dart';
import '/gux/common/success_page.dart';
import '/styles.dart' as styles;

class CommonPage extends StatefulWidget {
  @override
  CommonState createState() => CommonState();
}

class CommonState extends State<CommonPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('通用页面'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text('操作成功', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Text('\ue665', style: TextStyle(fontFamily: 'gx-iconfont', fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SuccessPage()),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: styles.padding, right: styles.padding),
              child: Divider(),
            ),
            ListTile(
              title: Text('操作失败', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Text('\ue665', style: TextStyle(fontFamily: 'gx-iconfont', fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FailurePage()),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: styles.padding, right: styles.padding),
              child: Divider(),
            ),
            ListTile(
              title: Text('恭喜祝贺', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Text('\ue665', style: TextStyle(fontFamily: 'gx-iconfont', fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CongratulationPage()),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: styles.padding, right: styles.padding),
              child: Divider(),
            ),
            ListTile(
              title: Text('感谢支持', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Text('\ue665', style: TextStyle(fontFamily: 'gx-iconfont', fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ThankYouPage()),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: styles.padding, right: styles.padding),
              child: Divider(),
            ),
            ListTile(
              title: Text('没有连接', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Text('\ue665', style: TextStyle(fontFamily: 'gx-iconfont', fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NoInternetPage()),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: styles.padding, right: styles.padding),
              child: Divider(),
            ),
            ListTile(
              title: Text('正在建设', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Text('\ue665', style: TextStyle(fontFamily: 'gx-iconfont', fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UnderConstructionPage()),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: styles.padding, right: styles.padding),
              child: Divider(),
            ),
            ListTile(
              title: Text('文章浏览', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Text('\ue665', style: TextStyle(fontFamily: 'gx-iconfont', fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ArticlePage()),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: styles.padding, right: styles.padding),
              child: Divider(),
            ),
          ],
        ),
      ),
    );
  }

}
