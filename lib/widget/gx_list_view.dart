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
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'gx_widget_size.dart';

typedef ColumIndexedWidgetBuilder =
GXWidgetSize Function(BuildContext context, Map<String, dynamic> item, int columnIndex);

typedef DataLoadBuilder = Function(Future<List<Map<String,dynamic>>>);

class GXListView extends StatefulWidget {

  final Future<List<Map<String,dynamic>>> future;

  final ColumIndexedWidgetBuilder itemBuilder;

  final DataLoadBuilder? loadBuilder;

  const GXListView({
    Key? key,
    required this.future,
    required ColumIndexedWidgetBuilder this.itemBuilder,
    DataLoadBuilder? this.loadBuilder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => GXListViewState();
}

class GXListViewState extends State<GXListView> {

  final ScrollController _scrollController = ScrollController();

  bool _loading = false;

  late Future<List<Map<String,dynamic>>> _future;

  List<Map<String,dynamic>> _data = [];

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
    return SingleChildScrollView(
      controller: _scrollController,
      physics: AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot<List<Map<String,dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('ERROR'));
            } else if (snapshot.hasData) {
              if (snapshot.data!.length == 0) {
                // no data
              }
              _data.addAll(snapshot.data!);
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: buildList(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState((){
        _loading = false;
      });
      if (widget.loadBuilder != null) {
        widget.loadBuilder!(_future);
      }
    }
  }

  List<Widget> buildList() {
    List<Widget> ret = [];
    for (int i = 0; i < _data.length; i++) {
      Map<String,dynamic> item = _data[i];
      GXWidgetSize widgetSize = widget.itemBuilder(context, item, i);
      ret.add(widgetSize.child);
    }
    if (_loading) {
      ret.add(SizedBox(height: 8));
      ret.add(Center(
        child: CircularProgressIndicator(),
      ));
    }
    return ret;
  }
}