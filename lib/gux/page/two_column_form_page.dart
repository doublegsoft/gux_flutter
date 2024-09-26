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
import 'package:gux/widget/gx_two_column_form.dart';

import '/styles.dart' as styles;

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
        child: styles.buildCard(
          child: GXTwoColumnForm(
            fields: getFields(),
          ),
        ),
      )

    );
  }

  List<Map<String, dynamic>> getFields() {
    List<Map<String, dynamic>> ret = [];
    Map<String,dynamic> field = {};

    field["input"] = "avatar";
    field["name"] = "avatar";
    ret.add(field);

    field = {};
    field["title"] = "基本信息";
    field["input"] = "title";
    ret.add(field);

    field = {};
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
    field["title"] = "身高";
    field["name"] = "height";
    field["input"] = "ruler";
    field["range"] = [100, 260];
    field["unit"] = "cm";
    ret.add(field);

    field = {};
    field["title"] = "体重";
    field["name"] = "weight";
    field["input"] = "ruler";
    field["range"] = [30, 150];
    field["unit"] = "kg";
    ret.add(field);

    field = {};
    field["title"] = "其他信息";
    field["input"] = "title";
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
