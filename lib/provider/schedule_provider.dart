

import 'package:flutter/material.dart';
import 'package:gux/model/dto.dart';
import 'package:gux/sdk/sdk.dart' as sdk;

class ScheduleProvider extends ChangeNotifier {

  sdk.DataState _state = sdk.DataState.idle;

  sdk.DataState get state => _state;

  List<ScheduleQuery> _schedules = [];

  List<ScheduleQuery> get schedules => _schedules;

  Future<void> fetchSchedules(ScheduleQuery query) async {
    _state = sdk.DataState.loading;
    notifyListeners();
    try {
      _schedules = await sdk.loadSchedules(query);
      _state = sdk.DataState.success;
    } catch (ex) {
      _state = sdk.DataState.error;
    }
    notifyListeners();
  }
}