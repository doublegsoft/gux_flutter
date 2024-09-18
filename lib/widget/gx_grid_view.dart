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

typedef ColumIndexedWidgetBuilder =
GXWidgetSize Function(BuildContext context, Map<String, dynamic> item, int columnIndex);

typedef DataLoadBuilder = Function(Future<List<Map<String,dynamic>>>);

class GXGridView extends StatefulWidget {

  final Future<List<Map<String,dynamic>>> future;

  final ColumIndexedWidgetBuilder itemBuilder;

  final DataLoadBuilder? loadBuilder;

  const GXGridView({
    Key? key,
    required this.future,
    required ColumIndexedWidgetBuilder this.itemBuilder,
    DataLoadBuilder? this.loadBuilder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => GXGridViewState();
}

class GXGridViewState extends State<GXGridView> {

  final ScrollController _scrollController = ScrollController();

  late Future<List<Map<String,dynamic>>> _future;

  List<Map<String,dynamic>> _data = [];

  bool _loading = false;

  int _firstColumnHeight = 0;

  int _secondColumnHeight = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _future = widget.future;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _firstColumnHeight = 0;
    _secondColumnHeight = 0;
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('ERROR'));
        } else if (snapshot.hasData) {
          if (snapshot.data!.length == 0) {
            // no data
          }
          _data.addAll(snapshot.data!);
          List<Widget> cols = buildColumns();
          // _scrollController.animateTo(
          //   _scrollController.position.maxScrollExtent,
          //   duration: Duration(milliseconds: 100),
          //   curve: Curves.easeInOut,
          // );
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
        return Container();
      },
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _data.addAll([{},{},{},{}]);
      setState((){});
    }
  }

  List<Widget> buildColumns() {
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