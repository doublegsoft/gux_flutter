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

import '../design/styles.dart' as styles;

typedef ColumIndexedWidgetBuilder =
GXWidgetSize Function(BuildContext context, Map<String, dynamic> item, int columnIndex);

typedef LoadMoreCallback = Future<void> Function();

class GXListView extends StatefulWidget {

  final ColumIndexedWidgetBuilder itemBuilder;

  final LoadMoreCallback? onLoadMore;

  final Widget? widgetLoadMore;

  final List? data;

  final int start;

  const GXListView({
    Key? key,
    required this.start,
    required ColumIndexedWidgetBuilder this.itemBuilder,
    this.onLoadMore,
    this.data,
    this.widgetLoadMore,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => GXListViewState();
}

class GXListViewState extends State<GXListView> {

  final ScrollController _scrollController = ScrollController();

  GXLoadMoreStatus _loadMoreStatus = GXLoadMoreStatus.idle;

  late double _bottomOffset;

  @override
  void initState() {
    super.initState();
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
    return NotificationListener<ScrollEndNotification>(
      onNotification: (ScrollEndNotification scrollEnd) {
        final metrics = scrollEnd.metrics;
        if (!metrics.atEdge) return true;
        if (metrics.pixels == 0) return true;
        if (_loadMoreStatus == GXLoadMoreStatus.loading) {
          widget.onLoadMore!().then((_) {
            setState(() {
              _loadMoreStatus = GXLoadMoreStatus.idle;
              _bottomOffset = 0;
            });
          });

        }
        return true;
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                final item = widget.data![index];
                return widget.itemBuilder(context, item, index);
              },
              childCount: widget.data!.length,
            ),
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
      if ((_scrollController.offset - _bottomOffset) > 150) {
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
}