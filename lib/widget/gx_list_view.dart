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

import 'gx_load_more.dart';
import 'gx_widget_size.dart';

import '/styles.dart' as styles;

typedef ColumIndexedWidgetBuilder =
GXWidgetSize Function(BuildContext context, Map<String, dynamic> item, int columnIndex);

typedef LoadMoreCallback = Future<List> Function();

class GXListView extends StatefulWidget {

  final ColumIndexedWidgetBuilder itemBuilder;

  final LoadMoreCallback? onLoadMore;

  final Widget? widgetLoadMore;

  final int start;

  const GXListView({
    Key? key,
    required this.start,
    required ColumIndexedWidgetBuilder this.itemBuilder,
    this.onLoadMore,
    this.widgetLoadMore,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => GXListViewState();
}

class GXListViewState extends State<GXListView> {

  final ScrollController _scrollController = ScrollController();

  List _data = [];

  late Future<void> _future4LoadMore;

  late GXLoadMoreStatus _loadMoreStatus;

  late double _bottomOffset;

  @override
  void initState() {
    super.initState();
    _future4LoadMore = _loadMore();
    if (widget.onLoadMore != null) {
      _scrollController.addListener(_scrollListener);
      _loadMoreStatus = GXLoadMoreStatus.idle;
      _bottomOffset = 0;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.start == -1) {
      _data.clear();
      setState(() {
        _future4LoadMore = _loadMore();
      });
    }
    return NotificationListener<ScrollEndNotification>(
      onNotification: (ScrollEndNotification scrollEnd) {
        final metrics = scrollEnd.metrics;
        if (!metrics.atEdge) return true;
        if (metrics.pixels == 0) return true;
        if (_loadMoreStatus == GXLoadMoreStatus.loading) {
          _loadMore();
        }
        return true;
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          FutureBuilder(
            future: _future4LoadMore,
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverToBoxAdapter(
                  child: Container(),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text('错误')),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final item = _data[index];
                    return widget.itemBuilder(context, item, index);
                  },
                  childCount: _data.length,
                ),
              );
            },
          ),
          if (_loadMoreStatus == GXLoadMoreStatus.loading) SliverToBoxAdapter(
            child: widget.widgetLoadMore,
          ),
        ],
      ),
    );
  }

  void _scrollListener() async {
    if (_loadMoreStatus == GXLoadMoreStatus.loading) {
      return;
    }
    if (_loadMoreStatus == GXLoadMoreStatus.touching) {
      if ((_scrollController.offset - _bottomOffset) > 50) {
        _loadMoreStatus = GXLoadMoreStatus.settling;
      }
      return;
    }
    if (_loadMoreStatus == GXLoadMoreStatus.settling) {
      setState(() {
        _loadMoreStatus = GXLoadMoreStatus.loading;
      });
    }
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (_loadMoreStatus == GXLoadMoreStatus.idle) {
        setState(() {
          _loadMoreStatus = GXLoadMoreStatus.touching;
          _bottomOffset = _scrollController.offset;
        });
      }
    }
  }

  Future<void> _loadMore() async {
    if (widget.start == 0) {
      _data.clear();
    }
    if (widget.onLoadMore != null) {
      List data = await widget.onLoadMore!();
      _data.addAll(data);
    }
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );
    setState(() {
      _loadMoreStatus = GXLoadMoreStatus.idle;
      _bottomOffset = 0;
    });
  }
}