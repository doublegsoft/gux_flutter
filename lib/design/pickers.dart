import 'package:flutter/material.dart';

import 'bottom_picker.dart';
import 'datetime_picker.dart';
import 'ruler_picker.dart';
import '/sdk/options.dart';

void pickDate(BuildContext context, {
  DateTime? initial,
  Function(DateTime? value)? onSelected,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(  // Rounded corners
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DateTimePicker(
        mode: DateTimePickerMode.date,
        value: initial??null,
        onSelected: (value) {
          if (onSelected != null) {
            onSelected(value);
          }
        },
      );
    },
  );
}

void pickTime(BuildContext context, {
  DateTime? initial,
  Function(DateTime? value)? onSelected,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(  // Rounded corners
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DateTimePicker(
        mode: DateTimePickerMode.time,
        value: initial??null,
        onSelected: (value) {
          if (onSelected != null) {
            onSelected(value);
          }
        },
      );
    },
  );
}

void pickOption(BuildContext context, {
  DateTime? initial,
  List<Option> options = const <Option>[],
  Function(Option? value)? onSelected,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(  // Rounded corners
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => BottomPicker(
      options: options.map<BottomPickerOption>((opt) => BottomPickerOption(
        value: opt.value,
        label: opt.text,
      )).toList(),
      value: '',
      onSelected: (option) {
        if (option == BottomPickerOption.NONE) {
          if (onSelected != null) {
            onSelected(null);
          }
        } else {
          if (onSelected != null) {
            onSelected(Option(
              text: option.label!,
              value: option.value,
            ));
          }
        }
      },
    ),
  );
}

void pickRuler(BuildContext context, {
  double? initial,
  int? max,
  int? min,
  Function(num? value)? onSelected,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(  // Rounded corners
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return GXRulerPicker(
        max: max??100,
        min: min??0,
        value: initial??0,
        onValueChanged: (value) {
          if (value == double.infinity) {
            if (onSelected != null) {
              onSelected(null);
            }
          } else {
            if (onSelected != null) {
              onSelected(value);
            }
          }
        },
      );
    },
  );
}