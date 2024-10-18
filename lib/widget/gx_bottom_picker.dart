import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/styles.dart' as styles;

class GXBottomPickerOption {

  static GXBottomPickerOption NONE = GXBottomPickerOption(value:'', label: '');

  final String value;
  final String label;
  final String? text;

  GXBottomPickerOption({
    required this.value,
    required this.label,
    this.text,
  });

}

class GXBottomPicker extends StatelessWidget {

  GXBottomPicker({
    super.key,
    required this.options,
    required this.onSelected,
    this.value,
    this.title,
    this.clearable,
  });

  final List<GXBottomPickerOption> options;
  final Function(GXBottomPickerOption) onSelected;
  final String? title;
  String? value = '';
  bool? clearable = true;

  GXBottomPickerOption? _selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 248,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (clearable??true) GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: styles.padding),
                        child: Text('清除', style: TextStyle(fontSize: 16, color: styles.colorError)),
                      ),
                      onTap: () {
                        onSelected(GXBottomPickerOption.NONE);
                        Navigator.pop(context);
                      },
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: styles.padding),
                        child: Text('取消', style: TextStyle(fontSize: 16, color: styles.colorError)),
                      ),
                      onTap: () {
                        if (value == '') {
                          onSelected(GXBottomPickerOption.NONE);
                        } else {
                          onSelected(options[options.indexOf(
                            options.firstWhere((element) => element.value == value,),
                          )]);
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
                    onSelected(_selected??GXBottomPickerOption.NONE);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: CupertinoPicker(
              backgroundColor: Colors.white,
              magnification: 1.25,
              itemExtent: 40,
              scrollController: FixedExtentScrollController(
                initialItem: value == '' ? 0 : options.indexOf(
                  options.firstWhere((element) => element.value == value,),
                ),
              ),
              onSelectedItemChanged: (int index) {
                // onSelected(
                //   options[index],
                // );
                _selected = options[index];
              },
              children: options.map((option) => Center(
                child: GestureDetector(
                  onTap: () {
                    onSelected(option);
                    Navigator.pop(context, option.value);
                  },
                  child: Text(
                    option.label,
                    style: TextStyle(
                      fontSize: 15,
                      color: styles.colorTextPrimary,
                    ),
                  ),
                ),
              ),).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class GXBottomPickerRadio extends StatefulWidget {
  const GXBottomPickerRadio({
    super.key,
    this.title,
    this.initialValue,
    required this.options,
  });

  final String? title;
  final String? initialValue;
  final List<GXBottomPickerOption> options;

  @override
  State<GXBottomPickerRadio> createState() => GXBottomPickerRadioState();
}

class GXBottomPickerRadioState extends State<GXBottomPickerRadio> {
  String? _value;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      setState(() {
        _value = widget.initialValue ?? widget.options[0].value;
      });
    }
  }

  void _onChanged(String? newValue, BuildContext context) {
    setState(() {
      _value = newValue;
    });
    Navigator.pop(context, newValue);
  }

  @override
  build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white70,
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.title ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white70,
              ),
              child: Column(
                children: [
                  ...widget.options.map(
                        (option) => ListTile(
                      onTap: () => _onChanged(option.value, context),
                      title: Text(option.label),
                      subtitle:
                      option.text != null ? Text(option.text ?? '') : null,
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 5,
                        right: 5,
                      ),
                      minVerticalPadding: 0,
                      leading: Radio<String>(
                        visualDensity: const VisualDensity(
                          horizontal: -4,
                        ),
                        value: option.value,
                        groupValue: _value,
                        onChanged: (String? value) =>
                            _onChanged(value, context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
