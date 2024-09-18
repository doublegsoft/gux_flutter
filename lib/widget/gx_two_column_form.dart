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
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

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

  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    widget.fields.forEach((field) {
      if (field['input'] == 'text') {
        _controllers[field['name']] = TextEditingController();
      } else if (field['input'] == 'date') {
        _controllers[field['name']] = TextEditingController();
      }
    });
  }

  @override
  void dispose() {
    _controllers.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildFieldRows(),
        ),
      ),
    );
  }

  List<Widget> buildFieldRows() {
    List<Widget> ret = [];
    widget.fields.forEach((field) {
      Padding padding = Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: buildFieldRow(field),
      );
      ret.add(padding);
    });
    return ret;
  }

  Widget buildFieldRow(Map<String, dynamic> field) {
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
        image = AssetImage('asset/image/gux.png');
      }

      return Center(
        child: GestureDetector(
          child: CircleAvatar(
            radius: 64,
            backgroundColor: Colors.blue,
            backgroundImage: image,
          ),
          onTap: () {
            openImageSourceActionSheet(context, field['name']);
          },
        ),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: widget.labelWidth.toDouble(),
            child: Padding(
              padding: EdgeInsets.only(top: 12,),
              child: Text(
                (field['title'] as String) + '：',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),),
          ),
          Expanded(
            child: buildFieldWidget(field),
          ),
        ],
      );
    }
  }

  Widget buildFieldWidget(Map<String, dynamic> field) {
    if (field['input'] == 'date') {
      return TextField(
        controller: _controllers[field['name']],
        focusNode: AlwaysDisabledFocusNode(),
        style: TextStyle(fontSize: 16),
        onTap: () {
          selectDate(context, field['name']);
        },
        decoration: InputDecoration(
          hintText: '请选择...',
          contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: 4),
        ),
      );
    } else if (field['input'] == 'select') {
      return DropdownButtonFormField<String>(
        onChanged: (value) {
          setState(() {
            _values[field['name']] = value;
          });
        },
        items: field['options']['values'].map<DropdownMenuItem<String>>((single) => DropdownMenuItem(
          value: single['value'] as String,
          child: Text(single['text'] as String),
        )).toList(),
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 16),
          hintText: '请选择...',
          contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: 12),
        ),
      );
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
      return buildWidgetForImages(field);
    } else if (field['input'] == 'segment') {
      return buildWidgetForSegment(field);
    } else {
      return TextField(
        controller: _controllers[field['name']],
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: '请填写',
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        ),
      );
    }
  }

  /*!
  ** Select a date value from date picker to display.
  **
  ** @private
  */
  Future<void> selectDate(BuildContext context, String name) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _values[name] ?? DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _values[name] = picked;
        _controllers[name]?.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  /*!
  ** Picks an image from image source, and make callback to display.
  **
  ** @private
  */
  Future<void> pickImage(ImageSource source, String name) async {
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
  void openImageSourceActionSheet(BuildContext context, String name) {
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
                pickImage(ImageSource.gallery, name);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('相机'),
              onTap: () {
                Navigator.of(context).pop();
                pickImage(ImageSource.camera, name);
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
  void openImageDialog(BuildContext context, Map<String, dynamic> image) {
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

  /*!
  ** Builds images input widget.
  **
  ** @private
  */
  Widget buildWidgetForImages(dynamic field) {
    String name = field['name'];
    List<dynamic> images = _values[name] ?? [];
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: 96 * ((images.length / 3).toInt() + 1) + (images.length / 3).toInt() * 4,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: images.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == images.length) {
            return GestureDetector(
              onTap: () {
                openImageSourceActionSheet(context, name);
              },
              child: Image.asset(
                'asset/image/icon/add-image.png',
                fit: BoxFit.cover,
              ),
            );
          }
          Map<String,dynamic> image = images[index] as Map<String,dynamic>;
          return GestureDetector(
            onTap: () {
              openImageDialog(context, image);
            },
            child: Container(
              width: 64,
              height: 64,
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
  }

  /*!
  ** Builds segment input widget.
  **
  ** @private
  */
  Widget buildWidgetForSegment(dynamic field) {
    Map options = field['options'];
    String name = field['name'];
    List values = options['values'];
    List<Widget> items = [];
    for (int i = 0; i < values.length; i++) {
      items.add(buildWidgetForSegmentItem(name, values[i]['value'], values[i]['text'], i, values.length));
    }
    return Container(
      padding: EdgeInsets.only(top: 6),
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
          border: Border(
            top: BorderSide(
              color: Colors.blue, // Top border color
              width: 2, // Top border width
            ),
            bottom: BorderSide(
              color: Colors.blue, // Bottom border color
              width: 2, // Bottom border width
            ),
            left: BorderSide(
              color: Colors.blue, // Left border color
              width: 2, // Left border width
            ),
            right: (index == count - 1) ? BorderSide(
              color: Colors.blue, // Left border color
              width: 2, // Left border width
            ) : BorderSide.none,
          ),
          borderRadius: BorderRadius.horizontal(
            left: index == 0 ? Radius.circular(10.0) : Radius.zero,
            right: (index == count - 1) ? Radius.circular(10.0) : Radius.zero,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 32,
              width: 64,
              color: (_values[name] == value) ? Colors.blue : Colors.transparent,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: (_values[name] == value) ? Colors.white : Colors.blue,
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
}