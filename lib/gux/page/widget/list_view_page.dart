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
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gux/widget/gx_list_view.dart';
import 'package:gux/widget/gx_widget_size.dart';
import 'package:gux/widget/gx_pull_to_refresh.dart';

import "/styles.dart" as styles;


class ListViewPage extends StatefulWidget {
  @override
  ListViewState createState() => ListViewState();
}

class ListViewState extends State<ListViewPage> {

  int _start = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('传统列表'),
      ),
      body: GXPullToRefresh(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2,));
          setState(() {
            _start = -1 /* refresh */;
          });
        },
        title: '', // 正在刷新数据...
        height: 160,
        image: Image.asset('asset/image/common/loading.gif', width: 150, height: 105, fit: BoxFit.cover),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        body: GXListView(
          start: _start,
          onLoadMore: fetchData,
          widgetLoadMore: Container(
            height: 150,
            child: Center(
              child: Image.asset('asset/image/common/loading.gif', width: 150, height: 105, fit: BoxFit.cover),
            ),
          ),
          itemBuilder: (context, item, columnIndex) {
            return GXWidgetSize(
              height: 120,
              onChange: (size) {},
              child: styles.buildTile(context,
                title: item['title'],
                accent: Container(
                  margin: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  width: 100,
                  height: 40,
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 3),
                            FlSpot(1, 2),
                            FlSpot(2, 5),
                            FlSpot(3, 3),
                            FlSpot(4, 6),
                            FlSpot(5, 4),
                            FlSpot(6, 7),
                          ],
                          isCurved: true,
                          color: Colors.blue,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: true,
                          ),
                          belowBarData: BarAreaData(
                            show: false,
                          ),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        show: false,
                      ),
                      gridData: FlGridData(
                        show: false,
                      ),
                      borderData: FlBorderData(
                        show: false, // 隐藏边框
                      ),
                    ),
                  ),
                ),
                description: item['description'],
              ),
            );
          },
        ),
      ),

    );
  }

  GXWidgetSize _buildCard(int columnIndex) {
    return GXWidgetSize(
      child: Container(
        padding: EdgeInsets.only(bottom: 8.0),
        height: columnIndex == 0 ? 220 : 320,
        color: Color.fromRGBO(234,234,234,1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 160,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.network('https://picsum.photos/300/160'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("hello", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("world", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            (columnIndex == 0 ? Container() : Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical:0,horizontal:16),
                child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. when an unknown printer took a galley of type and scrambled it to make a type specimen book.", style: TextStyle(fontSize: 12)),
              ),
            )
            ),
          ],
        ),
      ),
      height: columnIndex == 0 ? 220 : 320,
      onChange: (size) {},
    );
  }

  Future<List<Map<String,dynamic>>> fetchData() async {
    await Future.delayed(Duration(seconds: 1));
    if (_start == -1) {
      _start = 0;
    }
    setState(() {
      _start += 7;
    });

    return [{
      'title':'传统列表', 'description':'传统列表是一种最常用的集合数据展现方式',
    },{
      'title':'传统列表', 'description':'传统列表是一种最常用的集合数据展现方式',
    },{
      'title':'传统列表', 'description':'传统列表是一种最常用的集合数据展现方式',
    },{
      'title':'传统列表', 'description':'传统列表是一种最常用的集合数据展现方式',
    },{
      'title':'传统列表', 'description':'传统列表是一种最常用的集合数据展现方式',
    },{
      'title':'传统列表', 'description':'传统列表是一种最常用的集合数据展现方式',
    },{
      'title':'传统列表', 'description':'传统列表是一种最常用的集合数据展现方式',
    // },{
    //   'title':'传统列表', 'description':'传统列表是一种最常用的集合数据展现方式',
    // },{
    //   'title':'传统列表', 'description':'传统列表是一种最常用的集合数据展现方式',
    // },{
    //   'title':'传统列表', 'description':'传统列表是一种最常用的集合数据展现方式',
    // },{
    //   'title':'传统列表', 'description':'传统列表是一种最常用的集合数据展现方式',
    // },{
    //   'title':'传统列表', 'description':'传统列表是一种最常用的集合数据展现方式',
    // },{
    //   'title':'传统列表', 'description':'传统列表是一种最常用的集合数据展现方式',
    }];
  }
}
