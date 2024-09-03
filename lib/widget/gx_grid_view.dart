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
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

import 'gx_widget_size.dart';

typedef NullableColumIndexedWidgetBuilder =
GXWidgetSize Function(BuildContext context, Map<String, dynamic> item, int columnIndex);

class GXGridView extends StatefulWidget {

  final List<Map<String, dynamic>> data;

  final NullableColumIndexedWidgetBuilder itemBuilder;

  const GXGridView({
    Key? key,
    required this.data,
    required NullableColumIndexedWidgetBuilder this.itemBuilder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => GXGridViewState();
}

class GXGridViewState extends State<GXGridView> {

  final ScrollController _scrollController = ScrollController();

  bool _loading = false;

  List<Map<String,dynamic>> _data = [];

  int _firstColumnHeight = 0;

  int _secondColumnHeight = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _data = widget.data;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> cols = buildColumns();
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cols[0],
            SizedBox(width: 8),
            cols[1],
          ],
        ),
      ),
    );
  }

  // Size getWidgetSize() {
  //   final RenderBox renderBox = _itemKey.currentContext!.findRenderObject() as RenderBox;
  //   final size = renderBox.size;
  //   final position = renderBox.localToGlobal(Offset.zero);
  //   print('Size: ${size.width} x ${size.height}');
  //   print('Position: ${position.dx}, ${position.dy}');
  //   return size;
  // }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _data.addAll([{},{},{},{}]);
      setState((){});
    }
  }

  List<Widget> buildColumns() {
    _firstColumnHeight = 0;
    _secondColumnHeight = 0;
    List<Widget> ret = [];
    List<Widget> widgetsInFirstCol = [];
    List<Widget> widgetsInSecondCol = [];
    for (int i = 0; i < _data.length; i++) {
      Map<String,dynamic> item = _data[i];
      GXWidgetSize widgetSize = widget.itemBuilder(context, item, i % 2);
      if (_firstColumnHeight <= _secondColumnHeight) {
        widgetsInFirstCol.add(widgetSize.child);
        widgetsInFirstCol.add(SizedBox(height: 8));
        _firstColumnHeight += 8 + widgetSize.height;
      } else {
        widgetsInSecondCol.add(widgetSize.child);
        widgetsInSecondCol.add(SizedBox(height: 8));
        _secondColumnHeight += 8 + widgetSize.height;
      }
    }

    Widget firstColumn = Expanded(
      flex: 1,
      child: Column(
        children: widgetsInFirstCol,
      ),
    );

    Widget secondColumn = Expanded(
      flex: 1,
      child: Column(
        children: widgetsInSecondCol,
      ),
    );

    ret.add(firstColumn);
    ret.add(secondColumn);
    return ret;
  }
}