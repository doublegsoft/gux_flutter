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
import 'package:gux/widget/form/two_column_form.dart';

class TwoColumnFormPage extends StatefulWidget {
  @override
  TwoColumnFormPageState createState() => TwoColumnFormPageState();
}

class TwoColumnFormPageState extends State<TwoColumnFormPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('编辑表单'),
      ),
      body: SingleChildScrollView(
        child: TwoColumnForm(
          fields: getFields(),
        ),
      )

    );
  }

  List<Map<String, dynamic>> getFields() {
    List<Map<String, dynamic>> ret = [];
    Map<String,dynamic> field = {};
    field["title"] = "姓名";
    field["name"] = "name";
    field["input"] = "text";
    ret.add(field);

    field = {};
    field["title"] = "手机";
    field["name"] = "mobile";
    field["input"] = "text";
    ret.add(field);

    field = {};
    field["title"] = "性别";
    field["name"] = "gender";
    field["input"] = "segment";
    field["options"] = {
      "values": [{
        "text": "男", "value": "男"
      }, {
        "text": "女", "value": "女"
      }]
    };
    ret.add(field);

    field = {};
    field["title"] = "出生日期";
    field["name"] = "birthdate";
    field["input"] = "date";
    ret.add(field);

    field = {};
    field["title"] = "宠物";
    field["name"] = "pet";
    field["input"] = "select";
    field["options"] = {
      "values": [{
        "text": "阿猫", "value": "A"
      }, {
        "text": "阿狗", "value": "B"
      }, {
        "text": "恐龙", "value": "C"
      }]
    };
    ret.add(field);

    field = {};
    field["title"] = "照片";
    field["name"] = "images";
    field["input"] = "images";
    ret.add(field);

    return ret;
  }
}
