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
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:gux/widget/gx_grid_view.dart';
import 'package:gux/widget/gx_widget_size.dart';
import 'package:gux/widget/gx_list_view.dart';

import "/styles.dart" as styles;

class BarChartPage extends StatefulWidget {
  @override
  BarChartState createState() => BarChartState();
}

class BarChartState extends State<BarChartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('柱状图表'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: BarChart(
                BarChartData(
                  barGroups: [10, 20, 30, 40, 50, 60, 70]
                      .asMap()
                      .map((index, value) => MapEntry(
                    index,
                    BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: value.toDouble(),
                          color: Colors.blue,
                          width: 20,
                        ),
                      ],
                    ),
                  ))
                      .values
                      .toList(),
                  titlesData: FlTitlesData(
                    show: true,
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey,
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.grey,
                        strokeWidth: 1,
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: 150,
              height: 80,
              child: BarChart(
                BarChartData(
                  barGroups: [10, 20, 30, 40, 50, 60, 70]
                      .asMap()
                      .map((index, value) => MapEntry(
                    index,
                    BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: value.toDouble(),
                          color: Colors.blue,
                          width: 10,
                        ),
                      ],
                    ),
                  )).values.toList(),
                  titlesData: FlTitlesData(
                    show: false, // 隐藏标题
                  ),
                  gridData: FlGridData(
                    show: false, // 隐藏网格线
                  ),
                  borderData: FlBorderData(
                    show: false, // 隐藏边框
                  ),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }

}
