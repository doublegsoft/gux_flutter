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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'gx_widget_size.dart';

typedef NullableColumIndexedWidgetBuilder =
GXWidgetSize Function(BuildContext context, Map<String, dynamic> item, int columnIndex);

class GXListView extends StatefulWidget {

  final List<Map<String, dynamic>> data;

  final NullableColumIndexedWidgetBuilder itemBuilder;

  const GXListView({
    Key? key,
    required this.data,
    required NullableColumIndexedWidgetBuilder this.itemBuilder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => GXListViewState();
}

class GXListViewState extends State<GXListView> {

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
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildList(),
        ),
      ),
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _data.addAll([{},{},{},{}]);
      setState((){});
    }
  }

  List<Widget> buildList() {
    List<Widget> ret = [];
    for (int i = 0; i < _data.length; i++) {
      Map<String,dynamic> item = _data[i];
      GXWidgetSize widgetSize = widget.itemBuilder(context, item, i % 2);
      ret.add(widgetSize.child);
    }

    return ret;
  }
}