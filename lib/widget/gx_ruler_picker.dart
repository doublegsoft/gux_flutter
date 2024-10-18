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
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';

import '/styles.dart' as styles;

class GXRulerPicker extends StatefulWidget {

  final double? value;

  final int max;

  final int min;

  final ValueChangedCallback onValueChanged;

  const GXRulerPicker({
    Key? key,
    required this.max,
    required this.min,
    required this.onValueChanged,
    this.value = double.infinity,
  }) : super(key: key);

  @override
  GXRulerPickerState createState() => GXRulerPickerState();
}

class GXRulerPickerState extends State<GXRulerPicker> {

  final RulerPickerController _controller = RulerPickerController();

  late double _value;

  late double _oldValue;

  @override
  Widget build(BuildContext context) {
    _oldValue = widget.value!;
    if (_controller.value == 0) {
      _value = widget.value!;
      _controller.value = _value;
      if (_value == double.infinity) {
        _value = (widget.min + widget.max) / 2;
        _controller.value = _value;
      }
    }
    return Container(
      height: 192,
      child: Column(
        children: [
          Container(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: styles.padding),
                        child: Text('清除', style: TextStyle(fontSize: 16, color: styles.colorError)),
                      ),
                      onTap: () {
                        setState(() {
                          widget.onValueChanged(double.infinity);
                        });
                        Navigator.pop(context);
                      },
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: styles.padding),
                        child: Text('取消', style: TextStyle(fontSize: 16, color: styles.colorError)),
                      ),
                      onTap: () {
                        widget.onValueChanged(_oldValue);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Text(_value == double.infinity ? '' : _value.toInt().toString(),
                  style: TextStyle(fontSize: 16, color: styles.colorTextPrimary)
                ),
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(right: styles.padding),
                    child: Text('确定', style: TextStyle(fontSize: 16, color: styles.colorPrimary)),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          RulerPicker(
            controller: _controller,
            onBuildRulerScaleText: (index, value) {
              return value.toInt().toString();
            },
            ranges: [RulerRange(begin: widget.min, end: widget.max)],
            scaleLineStyleList: const [
              ScaleLineStyle(color: Colors.grey, width: 1.5, height: 30, scale: 0),
              ScaleLineStyle(color: Colors.grey, width: 1, height: 25, scale: 5),
              ScaleLineStyle(color: Colors.grey, width: 1, height: 15, scale: -1),
            ],
            onValueChanged: (value) {
              setState(() {
                _value = value.toDouble();
              });
              widget.onValueChanged(value);
            },
            width: MediaQuery.of(context).size.width,
            height: 80,
            rulerMarginTop: 0,
          ),
          Container(height: 64, color: Colors.white),
        ],
      ),
    );
  }

}