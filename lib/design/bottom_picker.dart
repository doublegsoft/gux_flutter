import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'buttons.dart';
import 'styles.dart' as styles;

class BottomPickerOption {

  static BottomPickerOption NONE = BottomPickerOption(value:'', label: '');

  final String value;
  final String label;
  final String? text;

  BottomPickerOption({
    required this.value,
    required this.label,
    this.text,
  });

}

class BottomPicker extends StatelessWidget {

  BottomPicker({
    super.key,
    required this.options,
    required this.onSelected,
    this.value,
    this.title,
    this.clearable,
  }) {
    if (options.isNotEmpty) {
      _selected = options[0];
    }
  }

  final List<BottomPickerOption> options;
  final Function(BottomPickerOption) onSelected;
  final String? title;
  String? value = '';
  bool? clearable = true;

  BottomPickerOption? _selected;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Colors.transparent,
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Container(
          height: 266,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
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
                            if (onSelected != null) {
                              onSelected(BottomPickerOption.NONE);
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    ConfirmIconButton(
                      didTap: () {
                        if (onSelected != null) {
                          onSelected(_selected ?? BottomPickerOption.NONE);
                        }
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 10,),
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
      },
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
  final List<BottomPickerOption> options;

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
