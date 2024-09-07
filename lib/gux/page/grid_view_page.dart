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

class GridViewPage extends StatefulWidget {
  @override
  GridViewState createState() => GridViewState();
}

class GridViewState extends State<GridViewPage> {

  List<Map<String, dynamic>> data = [{},{},{}];

  @override
  Widget build(BuildContext context) {
    data = [{},{},{},{},{},{},{}];
    return Scaffold(
      appBar: AppBar(
        title: Text('栅格列表'),
      ),
      body: GXGridView(
        data: data,
        itemBuilder: (context, item, columnIndex) {
          return _buildCard(columnIndex);
        },
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
                ]
              )
            ),
            (columnIndex == 0 ? Container() : Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical:0,horizontal:16),
                  child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. when an unknown printer took a galley of type and scrambled it to make a type specimen book.", style: TextStyle(fontSize: 12)),
                ),
              )
            ),
          ]
        )
      ),
      height: columnIndex == 0 ? 220 : 320,
      onChange: (size) {},
    );
  }
}
