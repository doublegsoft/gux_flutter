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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:gux/styles.dart' as styles;

class GXPullToRefresh extends StatefulWidget {

  final String title;

  final Widget image;

  final Widget body;

  final AsyncCallback onRefresh;

  final double? height;

  final Color? backgroundColor;

  final Color? foregroundColor;

  const GXPullToRefresh({
    Key? key,
    required this.title,
    required this.image,
    required this.body,
    required this.onRefresh,
    this.backgroundColor,
    this.foregroundColor,
    this.height,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => GXPullToRefreshState();
}

class GXPullToRefreshState extends State<GXPullToRefresh> with SingleTickerProviderStateMixin {

  IndicatorState _stateOfRefreshing = IndicatorState.idle;

  double _heightOfRefreshing = 0;

  late double _height;

  late Color _backgroundColor;

  late Color _foregroundColor;

  late AnimationController _controller;

  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();
    _height = widget.height ?? 200;
    _backgroundColor = widget.backgroundColor ?? Colors.transparent;
    _foregroundColor = widget.foregroundColor ?? styles.colorTextPrimary;

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        if (_stateOfRefreshing == IndicatorState.finalizing) {
          setState(() {
            _heightOfRefreshing = _height;
          });
        }
        await widget.onRefresh();
      },
      builder: (context, child, controller) {
        _heightOfRefreshing = _height * (controller.value >= 1 ? 1 : controller.value);
        if (controller.isFinalizing && _stateOfRefreshing != IndicatorState.finalizing) {
          _stateOfRefreshing = IndicatorState.finalizing;
          _heightOfRefreshing = _height;
        } else if (controller.isCanceling) {
          _stateOfRefreshing = IndicatorState.canceling;
        }
        return Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              color: Colors.black,
              width: styles.screenWidth,
              height: _heightOfRefreshing,
              child: Center(
                child: controller.isIdle ? Container() : _buildTitledProgressIndicator(),
              ),
            ),
            Transform.translate(
              offset: Offset(0, _height * controller.value),
              child: child,
            ),
          ],
        );
      },
      child: widget.body,
    );
  }

  Widget _buildTitledProgressIndicator() {
    return Container(
      height: 32,
      width: widget.title.length * 16 + 32,
      child: Row(
        children: [
          RotationTransition(
            turns: _animation,
            child: widget.image,
          ),
          SizedBox(width: 16),
          Text(widget.title,
            style: TextStyle(fontSize: 16, color: _foregroundColor),
          ),
        ],
      ),
    );
  }
}