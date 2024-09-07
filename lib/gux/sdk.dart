
import 'package:flutter/material.dart';
import '/common/xhr.dart' as xhr;

String HOST = "http://192.168.0.207:9098";

Future<List<Map<String,dynamic>>> fetchApplicationAdvertisements(Map<String,dynamic> params) async {
  Map<String,dynamic> resp = await xhr.post(
      HOST + '/api/v3/common/script/stdbiz/ams/application_advertisement/find',
      params);
  resp['data'].forEach((item) {
    item['imagePath'] = HOST + '/' + item['imagePath'];
  });
  List<Map<String,dynamic>> ret = [];
  resp['data'].forEach((item) {
    ret.add(item);
  });
  return ret;
}

Future<List<Map<String,dynamic>>> fetchApplicationNotifications(Map<String,dynamic> params) async {
  Map<String,dynamic> resp = await xhr.post(
      HOST + '/api/v3/common/script/stdbiz/ams/application_notification/find',
      params);
  List<Map<String,dynamic>> ret = [];
  resp['data'].forEach((item) {
    ret.add(item);
  });
  return ret;
}