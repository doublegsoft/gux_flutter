
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/sdk/options.dart';
import 'pickers.dart';
import 'styles.dart' as styles;

enum InputFieldType {
  text,
  date,
  time,
  select,
  ruler,
}

class InputField extends StatefulWidget {

  final String label;

  final bool nullable;

  final dynamic? value;

  final int? min;

  final int? max;

  final InputFieldType? type;

  final String? unit;

  int? length;

  final List<Option> options;

  final Function(dynamic)? didChanged;

  Color? background;

  InputField({super.key,
    required this.label,
    this.nullable = true,
    this.type = InputFieldType.text,
    this.options = const <Option>[],
    this.value,
    this.min,
    this.max,
    this.unit,
    this.length,
    this.didChanged,
    this.background,
  }) {
    if (this.background == null) {
      this.background = Color(0xff000000).withOpacity(0.04);
    }
  }

  @override
  State<StatefulWidget> createState() => InputFieldState();

}

class InputFieldState extends State<InputField> {

  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      if (widget.type == InputFieldType.ruler) {
        _controller.text = (widget.value as int).toString();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: widget.background,
        borderRadius: BorderRadius.circular(48),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: _buildLabel(),
          ),
          SizedBox(width: 8),
          if (widget.type == InputFieldType.text) _buildText(),
          if (widget.type == InputFieldType.date) _buildDate(),
          if (widget.type == InputFieldType.time) _buildTime(),
          if (widget.type == InputFieldType.select) _buildSelect(),
          if (widget.type == InputFieldType.ruler) _buildRuler(),
          ///
          /// 以下三种，只允许一种情况出现，是互斥的，有单位的必然是选择型数值输入；
          /// 有图标的必然是选择型输入；只有文本输入限制字数长度
          ///
          if (widget.unit != null) Text(widget.unit!, style: TextStyle(fontSize: 10,)),
          if (widget.type != InputFieldType.text && _getIcon() != null) Icon(_getIcon(), size: 16,),
          if (widget.length != null) Text('${_controller.text.length}/${widget.length}',
            style: TextStyle(fontSize: 10,),
          ),
        ]
      ),
    );
  }

  Widget _buildLabel() {
    return RichText(
      text: TextSpan(
        text: widget.label,
        style: TextStyle(fontSize: 14, color: styles.colorTextPrimary),
        children: [
          if (!widget.nullable) TextSpan(
            text: '*',
            style: TextStyle(fontSize: 14, color: styles.colorError),
          ),
          TextSpan(text: '：',
          )
        ],
      ),
    );
  }

  Widget _buildText() {
    return Expanded(
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: widget.type == InputFieldType.text ? '请填写' : '请选择...',
          hintStyle: TextStyle(fontSize: 14, color: styles.colorTextPlaceholder,),
          border: InputBorder.none,
        ),
        style: TextStyle(fontSize: 14,),
        onChanged: (value) {
          if (widget.length == null) {
            return;
          }
          setState(() {});
        },
        onSubmitted: (value) {
          if (widget.length == null) {
            return;
          }
          if (value.length > widget.length!) {
            _controller.text = value.substring(0, widget.length!);
          }
          setState(() {});
        },
      ),
    );
  }

  Widget _buildDate() {
    return Expanded(
      child: TextField(
        controller: _controller,
        readOnly: true,
        decoration: InputDecoration(
          hintText: '请选择...',
          hintStyle: TextStyle(fontSize: 14, color: styles.colorTextPlaceholder,),
          border: InputBorder.none,
        ),
        style: TextStyle(fontSize: 14,),
        onTap: () => _pickDate(context),
      ),
    );
  }

  Widget _buildTime() {
    return Expanded(
      child: TextField(
        controller: _controller,
        readOnly: true,
        decoration: InputDecoration(
          hintText: '请选择...',
          hintStyle: TextStyle(fontSize: 14, color: styles.colorTextPlaceholder,),
          border: InputBorder.none,
        ),
        style: TextStyle(fontSize: 14,),
        onTap: () => _pickTime(context),
      ),
    );
  }

  Widget _buildSelect() {
    return Expanded(
      child: TextField(
        controller: _controller,
        readOnly: true,
        decoration: InputDecoration(
          hintText: '请选择...',
          hintStyle: TextStyle(fontSize: 14, color: styles.colorTextPlaceholder,),
          border: InputBorder.none,
        ),
        style: TextStyle(fontSize: 14,),
        onTap: () => _pickOption(context),
      ),
    );
  }

  Widget _buildRuler() {
    return Expanded(
      child: TextField(
        controller: _controller,
        readOnly: true,
        decoration: InputDecoration(
          hintText: '请选择...',
          hintStyle: TextStyle(fontSize: 14, color: styles.colorTextPlaceholder,),
          border: InputBorder.none,
        ),
        style: TextStyle(fontSize: 14,),
        onTap: () => _pickRuler(context),
      ),
    );
  }

  IconData? _getIcon() {
    if (widget.type == InputFieldType.date) {
      return Icons.date_range_outlined;
    } else if (widget.type == InputFieldType.time) {
      return Icons.timer_sharp;
    } else if (widget.type == InputFieldType.select) {
      return Icons.arrow_drop_down_circle_outlined;
    }
    return null;
  }

  void _pickDate(BuildContext context) {
    pickDate(context,
      initial: widget.value,
      onSelected: (DateTime? value) {
        setState(() {
          if (value == null) {
            _controller.text = '';
          } else {
            _controller.text = DateFormat('yyyy-MM-dd').format(value as DateTime);
          }
        });
        if (widget.didChanged != null) {
          widget.didChanged!(value);
        }
      }
    );
  }

  void _pickTime(BuildContext context) {
    pickTime(context,
      initial: widget.value,
      onSelected: (DateTime? value) {
        setState(() {
          if (value == null) {
            _controller.text = '';
          } else {
            _controller.text = DateFormat('HH:mm').format(value as DateTime);
          }
        });
        if (widget.didChanged != null) {
          widget.didChanged!(value);
        }
      }
    );
  }

  void _pickOption(BuildContext context) async {
    pickOption(context,
      options: widget.options,
      onSelected: (Option? value) {
        setState(() {
          if (value == null) {
            _controller.text = '';
          } else {
            _controller.text = value.text;
          }
        });
        if (widget.didChanged != null) {
          if (value == null) {
            widget.didChanged!(null);
          } else {
            widget.didChanged!(value);
          }
        }
      }
    );
  }

  void _pickRuler(BuildContext context) {
    pickRuler(context,
      min: widget.min,
      max: widget.max,
      initial: widget.value,
      onSelected: (num? value) {
        setState(() {
          if (value == null) {
            _controller.text = '';
          } else {
            _controller.text = value.toInt().toString();
          }
        });
      }
    );
  }
}