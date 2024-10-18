
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/styles.dart' as styles;

enum GXDateTimePickerMode {
  date,
  time,
}

class GXDateTimePicker extends StatefulWidget {

  final GXDateTimePickerMode mode;

  final Function(DateTime?) onSelected;

  DateTime? value;

  GXDateTimePicker({
    required this.mode,
    required Function(DateTime?) this.onSelected,
    this.value,
  });

  @override
  State<StatefulWidget> createState() => GXDateTimePickerState();
}

class GXDateTimePickerState extends State<GXDateTimePicker> {

  DateTime? _oldValue;

  late DateTime _newValue;

  @override
  void initState() {
    super.initState();
    if (widget.value == null) {
      _newValue = DateTime.now();
    } else {
      _oldValue = widget.value!;
      _newValue = widget.value!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Colors.transparent,
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return _buildBody(context);
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        // color: widget.backgroundColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                          widget.onSelected(null);
                          Navigator.pop(context);
                        },
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: styles.padding),
                          child: Text('取消', style: TextStyle(fontSize: 16, color: styles.colorError)),
                        ),
                        onTap: () {
                          if (_oldValue != null) {
                            widget.onSelected(_oldValue!);
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Text('',
                      style: TextStyle(fontSize: 16, color: styles.colorTextPrimary)
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(right: styles.padding),
                      child: Text('确定', style: TextStyle(fontSize: 16, color: styles.colorPrimary)),
                    ),
                    onTap: () {
                      widget.onSelected(_newValue);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: _buildDatePicker(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.date,
      onDateTimeChanged: (val) {
        setState(() {
          _newValue = val;
        });
      },
      initialDateTime: _newValue,
      maximumDate: DateTime(2099),
      minimumDate: DateTime(1800),
      dateOrder: DatePickerDateOrder.ymd,
    );
  }
}