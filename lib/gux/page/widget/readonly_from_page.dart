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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gux/gux/bloc/form_bloc.dart';
import 'package:gux/widget/gx_two_column_form.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../design/styles.dart' as styles;

class ReadonlyFromPage extends StatefulWidget {
  @override
  ReadonlyFromPageState createState() => ReadonlyFromPageState();
}

class ReadonlyFromPageState extends State<ReadonlyFromPage> {

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('只读表单'),
        ),
        body: BlocConsumer<FormBloc, FormWhichState>(
          builder: (context, state) {
            if (state is FormLoadingState) {
              return Skeletonizer(
                enabled: true,
                child: GXTwoColumnForm(
                  fields: getFields({}),
                ),
              );
            }
            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(styles.padding),
                child: Column(
                  children: [
                    GXTwoColumnForm(
                      readonly: true,
                      fields: getFields(state.data),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {
            // print('listening: ${state.status}');
          },)
    );
  }

  List<Map<String, dynamic>> getFields(Map? data) {
    if (data == null) {
      data = {};
    }
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
    field['value'] = data['name']??'';
    ret.add(field);

    field = {};
    field["title"] = "手机";
    field["name"] = "mobile";
    field["input"] = "mobile";
    ret.add(field);

    field = {};
    field["title"] = "性别";
    field["name"] = "gender";
    field["input"] = "segment";
    field['value'] = '女';
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
    field['value'] = data['height']??double.infinity;
    ret.add(field);

    field = {};
    field["title"] = "体重";
    field["name"] = "weight";
    field["input"] = "ruler";
    field["range"] = [30, 150];
    field["unit"] = "kg";
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

    field = {};
    field["title"] = "地址";
    field["name"] = "address";
    field["input"] = "longtext";
    ret.add(field);

    field = {};
    field["title"] = "备注";
    field["name"] = "note";
    field["input"] = "longtext";
    ret.add(field);

    return ret;
  }
}
