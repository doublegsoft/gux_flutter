
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'buttons.dart';

enum DateTimePickerMode {
  date,
  time,
}

class DateTimePicker extends StatefulWidget {

  final DateTimePickerMode mode;

  final Function(DateTime?) onSelected;

  DateTime? value;

  DateTimePicker({
    required this.mode,
    required Function(DateTime?) this.onSelected,
    this.value,
  });

  @override
  State<StatefulWidget> createState() => DateTimePickerState();
}

class DateTimePickerState extends State<DateTimePicker> {

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
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 10,),
                    CloseIconButton(),
                    SizedBox(width: 20,),
                    ClearIconButton(
                      didTap: () {
                        widget.onSelected(null);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Spacer(),
                ConfirmIconButton(
                  didTap: () {
                    widget.onSelected(_newValue);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 10,),
              ],
            ),
          ),
          Expanded(
            child: widget.mode == DateTimePickerMode.date ? _buildDatePicker(context) : _buildTimePicker(context),
          ),
        ],
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

  Widget _buildTimePicker(BuildContext context) {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.time,
      use24hFormat: true,
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