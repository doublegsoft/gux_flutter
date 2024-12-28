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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gux/design/loading.dart';
import 'package:gux/gux/bloc/list_bloc.dart';
import 'package:gux/widget/gx_list_view.dart';
import 'package:gux/widget/gx_widget_size.dart';
import 'package:gux/widget/gx_pull_to_refresh.dart';

import "../../../design/styles.dart" as styles;


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
      body: BlocConsumer<ListBloc, ListWhichState>(
        builder: (context, state) {
          if (state is ListLoadingState) {
            return Center(child: Loading(),);
          }
          ListBloc bloc = context.read<ListBloc>();
          return GXPullToRefresh(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2,));
              setState(() {
                bloc.add(ListLoadEvent(start: 0));
              });
            },
            title: '',
            height: 160,
            image: Image.asset('asset/image/common/loading.gif', width: 150, height: 105, fit: BoxFit.cover),
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            body: GXListView(
              start: _start,
              data: bloc.loadedItems,
              onLoadMore: () async {
                context.read<ListBloc>().add(ListLoadEvent(silent: true,));
              },
              widgetLoadMore: Container(
                height: 150,
                child: Center(
                  child: Image.asset('asset/image/common/loading.gif', width: 150, height: 105, fit: BoxFit.cover),
                ),
              ),
              itemBuilder: (context, item, columnIndex) {
                return _buildTile(item);
              },
            ),
          );
        },
        listener: (context, state) {

        },
      ),
    );
  }

  GXWidgetSize _buildTile(Map item) {
    return GXWidgetSize(
      height: 120,
      onChange: (size) {},
      child: styles.buildTile(context,
        index: item['index'],
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
  }
}
