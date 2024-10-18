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
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:gux/widget/gx_datetime_picker.dart';
import 'package:gux/widget/gx_ruler_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


import '/styles.dart' as styles;
import 'gx_bottom_picker.dart';

const PADDING = 8.0;

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class GXTwoColumnForm extends StatefulWidget {

  final bool readonly;

  final int labelWidth;

  final List<Map<String, dynamic>> fields;

  const GXTwoColumnForm({
    Key? key,
    required this.fields,
    this.readonly = false,
    this.labelWidth = 100,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => GXTwoColumnFormState();
}

class GXTwoColumnFormState extends State<GXTwoColumnForm> {

  final Map<String, dynamic> _values = {};

  final Map<String, dynamic> _controllers = {};

  final TextEditingController _controllerForText = TextEditingController();

  late dynamic _focusField;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.fields.forEach((field) {
      if (field['input'] == 'ruler') {
        _controllers[field['name']] = RulerPickerController();
        _values[field['name']] = field['value']??double.infinity;
      }
    });
  }

  @override
  void dispose() {
    _controllers.forEach((key, value) {
      value.dispose();
    });
    _controllerForText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          setState(() {
            FocusScope.of(context).unfocus();
          });
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: PADDING),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._buildFieldRows(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Builds label and input row one by one in form.
  ///
  ///
  List<Widget> _buildFieldRows() {
    List<Widget> ret = [];
    widget.fields.forEach((field) {
      Widget widget = Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: PADDING),
        child: _buildFieldRow(field),
      );
      ret.add(widget);
    });
    return ret;
  }

  Widget _buildFieldRow(Map<String, dynamic> field) {
    if (field['input'] == 'title') {
      return Container(
        padding: EdgeInsets.only(top: 16),
        child: Text(field['title'],
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    } else if (field['input'] == 'avatar') {
      String name = field['name'];
      ImageProvider image;
      // image类型的值都是数组形式
      if (_values[name] != null) {
        image = FileImage(File(_values[name][0]['path']));
      } else {
        image = AssetImage('asset/image/common/avatar.png');
      }
      return Center(
        child: GestureDetector(
          child: CircleAvatar(
            radius: 64,
            backgroundImage: image,
          ),
          onTap: () {
            _pickImageSource(context, field['name']);
          },
        ),
      );
    } else {
      double top = 14;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: widget.labelWidth.toDouble(),
            child: Container(
              padding: EdgeInsets.only(top: top,),
              child: Text(
                (field['title'] as String) + '：',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),),
          ),
          Expanded(
            child: _buildFieldWidget(field),
          ),
        ],
      );
    }
  }

  Widget _buildFieldWidget(Map<String, dynamic> field) {
    if (field['input'] == 'date') {
      return _buildWidgetForDate(field);
    } else if (field['input'] == 'select') {
      return _buildWidgetForSelect(field);
    } else if (field['input'] == 'check') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            value: _values[field['name']] ?? false,
            onChanged: (value) {
              setState(() {
                _values[field['name']] = value;
              });
            },
          ),
          Text(field['title'], style: TextStyle(fontSize: 16),),
        ],
      );
    } else if (field['input'] == 'radio') {
      return Wrap(
        spacing: 0.0,
        children: [
          ...field['options']['values'].map((option) => RadioListTile<String>(
            contentPadding: EdgeInsets.all(0),
            title: Text(option['text']),
            value: option['value'],
            groupValue: _values[field['name']],
            onChanged: (value) {
              setState(() {
                _values[field['name']] = value;
              });
            },
          )),
        ],
      );
    } else if (field['input'] == 'images') {
      return _buildWidgetForImages(field);
    } else if (field['input'] == 'segment') {
      return _buildWidgetForSegment(field);
    } else if (field['input'] == 'ruler') {
      return _buildWidgetForRuler(field);
    } else if (field['input'] == 'longtext') {
      return _buildWidgetForLongText(field);
    } else {
      return _buildWidgetForText(field);
    }
  }

  /*!
  ** Select a date value from date picker to display.
  **
  ** @private
  */
  Future<void> _pickDate(BuildContext context, String name, String title) async {
    showModalBottomSheet(context: context, builder: (context) {
      return GXDateTimePicker(
        mode: GXDateTimePickerMode.date,
        value: _values[name],
        onSelected: (value) {
          setState(() {
            _values[name] = value;
          });
        },
      );
    });
  }

  /*!
  ** Picks an image from image source, and make callback to display.
  **
  ** @private
  */
  Future<void> _pickImage(ImageSource source, String name) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        if (_values[name] == null) {
          _values[name] = [];
        }
        _values[name].add({
          'path': pickedFile.path,
        });
      }
    });
  }

  /*!
  ** Opens action sheet to choose image source, gallery or camera.
  **
  ** @private
  */
  void _pickImageSource(BuildContext context, String name) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('相册'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery, name);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('相机'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera, name);
              },
            ),
          ],
        ),
      ),
    );
  }

  /*!
  ** Opens image dialog to display picking image.
  **
  ** @private
  */
  void _viewImage(BuildContext context, Map<String, dynamic> image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            height: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.file(
                      File(image['path']),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('关闭'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _inputText(dynamic field) {
    return Container();
  }

  /*!
  ** Builds images input widget.
  **
  ** @private
  */
  Widget _buildWidgetForImages(dynamic field) {
    String name = field['name'];
    List<dynamic> images = _values[name] ?? [];
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: styles.colorDivider,
              width: 1.0,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: PADDING),
        height: ((width - 16) / 3) * (((images.length + 1) / 3).toInt() + 1) + ((images.length + 1) / 3).toInt() * 8 + 16 + 1,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: images.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == images.length) {
              return GestureDetector(
                onTap: () {
                  _pickImageSource(context, name);
                },
                child: Image.asset(
                  'asset/image/icon/add-image_gray.png',
                  fit: BoxFit.cover,
                ),
              );
            }
            Map<String,dynamic> image = images[index] as Map<String,dynamic>;
            return GestureDetector(
              onTap: () {
                _viewImage(context, image);
              },
              child: Container(
                width: (width - 16) / 3,
                height: (width - 16) / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(image['path'])),
                    fit: BoxFit.cover, // Adjust this to fit your needs
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  /*!
  ** Builds segment input widget.
  **
  ** @private
  */
  Widget _buildWidgetForSegment(dynamic field) {
    Map options = field['options'];
    String name = field['name'];
    List values = options['values'];
    List<Widget> items = [];
    for (int i = 0; i < values.length; i++) {
      items.add(buildWidgetForSegmentItem(name, values[i]['value'], values[i]['text'], i, values.length));
    }
    return Container(
      padding: EdgeInsets.only(top: PADDING, bottom: PADDING),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: styles.colorDivider,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: items,
      ),
    );
  }

  Widget buildWidgetForSegmentItem(String name, String value, String text, int index, int count) {
    return InkWell(
      onTap: () {
        setState(() {
          _values[name] = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: _values[name] != value ? Border(
            top: BorderSide(
              color: styles.colorDivider,
              width: 2, // Top border width
            ),
            bottom: BorderSide(
              color: styles.colorDivider,
              width: 2, // Bottom border width
            ),
            left: BorderSide(
              color: styles.colorDivider,
              width: 2, // Left border width
            ),
            right: (index == count - 1) ? BorderSide(
              color: styles.colorDivider,
              width: 2, // Left border width
            ) : BorderSide.none,
          ) : Border(
            top: BorderSide(
              color: styles.colorDivider,
              width: 2, // Top border width
            ),
            bottom: BorderSide(
              color: styles.colorDivider,
              width: 2, // Bottom border width
            ),
            left: BorderSide(
              color: styles.colorDivider,
              width: 2, // Left border width
            ),
            right: (index == count - 1) ? BorderSide(
              color: styles.colorDivider,
              width: 2, // Left border width
            ) : BorderSide.none,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 32,
              width: 64,
              color: (_values[name] == value) ? styles.colorDivider : Colors.transparent,
              child: Center(
                child: Text(text,
                  style: TextStyle(
                    color: (_values[name] == value) ? styles.colorTextPrimary : styles.colorTextPlaceholder,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Builds widget for field with ruler input.
  ///
  /// [field] a raw map object as field
  ///
  Widget _buildWidgetForRuler(dynamic field) {
    String name = field['name']!;
    return Container(
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(bottom: 0, left: PADDING, right: PADDING / 2),
        title: Text((_values[name] == double.infinity ? '请选择...' : _values[name].toInt()).toString(),
          style: TextStyle(fontSize: 16, color: _values[name] == double.infinity ? styles.colorTextPlaceholder : styles.colorTextPrimary),
        ),
        trailing: field['unit'] != null ? Text(field['unit']) : null,
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return GXRulerPicker(
                max: field['range'][1],
                min: field['range'][0],
                value: _values[name],
                onValueChanged: (value) {
                  setState(() {
                    _values[name] = value.toDouble();
                  });
                },
              );
            },
          );
        },
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: styles.colorDivider,
            width: 1.0, // Width of the bottom border
          ),
        ),
      ),
    );
  }

  ///
  /// Builds widget for field with select input.
  ///
  /// [field] a raw map object as field
  ///
  Widget _buildWidgetForSelect(dynamic field) {
    return Container(
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(bottom: 0, left: PADDING, right: PADDING / 2),
        title: Text(((_values[field['name']]??'') == '' ? '请选择...' : _values[field['name'] + '_text']),
          style: TextStyle(fontSize: 16, color: (_values[field['name']]??'') == '' ? styles.colorTextPlaceholder : styles.colorTextPrimary),
        ),
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => GXBottomPicker(
              options: field['options']['values'].map<GXBottomPickerOption>((single) => GXBottomPickerOption(
                value: single['value'] as String,
                label: single['text'] as String,
              )).toList(),
              value: _values[field['name']]??'',
              onSelected: (option) {
                setState(() {
                  _values[field['name']] = option.value;
                  _values[field['name'] + '_text'] = option.label;
                });
              },
            ),
          );
        },
        trailing: Icon(Icons.keyboard_arrow_down, size: 22),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: styles.colorDivider,
            width: 1.0, // Width of the bottom border
          ),
        ),
      ),
    );
  }

  ///
  /// Builds widget for field with date input.
  ///
  /// [field] a raw map object as field
  ///
  Widget _buildWidgetForDate(dynamic field) {
    return Container(
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(bottom: 0, left: PADDING, right: PADDING),
        title: Text((_values[field['name']] == null ? '请选择...' : DateFormat('yyyy-MM-dd').format(_values[field['name']])),
          style: TextStyle(fontSize: 16, color: _values[field['name']] == null ? styles.colorTextPlaceholder : styles.colorTextPrimary),
        ),
        onTap: () {
          _pickDate(context, field['name'], field['title']);
        },
        trailing: Icon(Icons.calendar_today, size: 16),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: styles.colorDivider,
            width: 1.0, // Width of the bottom border
          ),
        ),
      ),
    );
  }

  ///
  /// Builds widget for field with longtext input.
  ///
  /// [field] a raw map object as field
  ///
  Widget _buildWidgetForLongText(dynamic field) {
    return Container(
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(bottom: 0, left: PADDING, right: PADDING),
        title: Text((_values[field['name']]??'') == '' ? '请填写' : _values[field['name']],
          style: TextStyle(fontSize: 16, color: (_values[field['name']]??'') == '' ? styles.colorTextPlaceholder : styles.colorTextPrimary),
        ),
        onTap: () {
          FocusScope.of(context).unfocus();
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              Future.delayed(Duration(milliseconds: 50), () {
                try {
                  FocusScope.of(context).requestFocus(_focusNode);
                } catch (error) {

                }
              });
              return Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: _buildTextInput(field),
              );
            }
          );
        },
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: styles.colorDivider,
            width: 1.0, // Width of the bottom border
          ),
        ),
      ),
    );
  }

  ///
  /// Builds widget for field with text input.
  ///
  /// [field] a raw map object as field
  ///
  Widget _buildWidgetForText(dynamic field) {
    return Container(
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(bottom: 0, left: PADDING, right: PADDING),
        title: Text((_values[field['name']]??'') == '' ? '请填写' : _values[field['name']],
          style: TextStyle(fontSize: 16, color: (_values[field['name']]??'') == '' ? styles.colorTextPlaceholder : styles.colorTextPrimary),
        ),
        onTap: () {
          FocusScope.of(context).unfocus();
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                Future.delayed(Duration(milliseconds: 50), () {
                  try {
                    FocusScope.of(context).requestFocus(_focusNode);
                  } catch (error) {

                  }
                });
                return Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: _buildTextInput(field),
                );
              }
          );
        },
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: styles.colorDivider,
            width: 1.0, // Width of the bottom border
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput(dynamic field) {
    // print(MediaQuery.of(context).viewInsets.bottom);
    String name = field['name'];
    if (_values[name] != null) {
      _controllerForText.text = _values[name];
    } else {
      _controllerForText.text = '';
    }
    return Container(
      height: 96,
      color: styles.colorDivider,
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
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: styles.padding),
                        child: Text('清除', style: TextStyle(fontSize: 16, color: styles.colorError)),
                      ),
                      onTap: () {
                        _values[name] = '';
                        Navigator.pop(context);
                        _controllerForText.text = '';
                      },
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: styles.padding),
                        child: Text('取消', style: TextStyle(fontSize: 16, color: styles.colorError)),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        _controllerForText.text = '';
                      },
                    ),
                  ],
                ),
                Text(field['title'],
                  style: TextStyle(fontSize: 16, color: styles.colorTextPrimary)
                ),
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(right: styles.padding),
                    child: Text('确定', style: TextStyle(fontSize: 16, color: styles.colorPrimary)),
                  ),
                  onTap: () {
                    _values[name] = _controllerForText.text;
                    Navigator.pop(context);
                    _controllerForText.text = '';
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: PADDING),
              margin: EdgeInsets.only(bottom: PADDING),
              child: Focus(
                onKeyEvent: (node, event) => KeyEventResult.handled,
                canRequestFocus: true,
                child: TextField(
                  controller: _controllerForText,
                  focusNode: _focusNode,
                  keyboardType: field['input'] == 'mobile' ? TextInputType.number : TextInputType.text,
                  style: TextStyle(fontSize: 16, height: 1,),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: styles.colorDivider,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: styles.colorDivider,
                      ),
                      borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}