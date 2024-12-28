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
import 'package:gux/model/dto.dart';

Future<List<ScheduleQuery>> loadSchedules(ScheduleQuery query) async {
  await Future.delayed(Duration(milliseconds: 1500),);
  return [
    ScheduleQuery(
      scheduleId: '1',
      startTime: DateTime(2024, 8, 28, 9, 0),
      endTime: DateTime(2024, 8, 28, 10, 0),
      location: '办公室',
      activity: '每日例会',
      note: '准备好每日工作汇报。',
      personId: 'user101',
    ),
    ScheduleQuery(
      scheduleId: '2',
      startTime: DateTime(2024, 8, 28, 10, 30),
      endTime: DateTime(2024, 8, 28, 12, 0),
      location: '会议室A',
      activity: '项目进度会议',
      note: '需要准备项目更新文档。',
      personId: 'user102',
    ),
    ScheduleQuery(
      scheduleId: '3',
      startTime: DateTime(2024, 8, 28, 14, 0),
      endTime: DateTime(2024, 8, 28, 16, 0),
      location: '客户办公室',
      activity: '客户演示',
      note: '带上演示用的设备。',
      personId: 'user103',
    ),
    ScheduleQuery(
      scheduleId: '4',
      startTime: DateTime(2024, 8, 29, 11, 0),
      endTime: DateTime(2024, 8, 29, 12, 0),
      location: '健身房',
      activity: '健身',
      note: '带上水壶和毛巾。',
      personId: 'user104',
    ),
    ScheduleQuery(
      scheduleId: '5',
      startTime: DateTime(2024, 8, 29, 15, 0),
      endTime: DateTime(2024, 8, 29, 17, 0),
      location: '图书馆',
      activity: '阅读',
      note: '还书。',
      personId: 'user105',
    ),
    ScheduleQuery(
      scheduleId: '6',
      startTime: DateTime(2024, 8, 29, 19, 0),
      endTime: DateTime(2024, 8, 29, 21, 0),
      location: '餐厅',
      activity: '晚餐',
      note: '和家人一起。',
      personId: 'user106',
    ),
    ScheduleQuery(
      scheduleId: '7',
      startTime: DateTime(2024, 8, 30, 9, 30),
      endTime:  DateTime(2024, 8, 30, 11, 0),
      location: '家里',
      activity: '学习',
      note: '准备新的课程。',
      personId: 'user107',
    ),
    ScheduleQuery(
      scheduleId: '8',
      startTime: DateTime(2024, 8, 30, 13, 30),
      endTime: DateTime(2024, 8, 30, 15, 0),
      location: '公司',
      activity: '代码审查',
      note: '确保代码质量。',
      personId: 'user108',
    ),
    ScheduleQuery(
      scheduleId: '9',
      startTime: DateTime(2024, 8, 31, 8, 0),
      endTime: DateTime(2024, 8, 31, 9, 0),
      location: '家',
      activity: '早起',
      note: '散步',
      personId: 'user109',
    ),
    ScheduleQuery(
      scheduleId: '10',
      startTime: DateTime(2024, 8, 31, 16, 0),
      endTime:  DateTime(2024, 8, 31, 18, 0),
      location: '公园',
      activity: '朋友聚会',
      note: '烧烤。',
      personId: 'user110',
    ),
    ScheduleQuery(
      scheduleId: '11',
      startTime: DateTime(2024, 9, 1, 10, 0),
      endTime: DateTime(2024, 9, 1, 12, 0),
      location: '商场',
      activity: '购物',
      note: '购买礼物',
      personId: 'user111',
    ),
    ScheduleQuery(
      scheduleId: '12',
      startTime: DateTime(2024, 9, 1, 17, 0),
      endTime: DateTime(2024, 9, 1, 19, 0),
      location: '电影院',
      activity: '看电影',
      note: '看新上映的电影。',
      personId: 'user112',
    ),
    ScheduleQuery(
      scheduleId: '13',
      startTime: DateTime(2024, 9, 2, 9, 0),
      endTime: DateTime(2024, 9, 2, 10, 0),
      location: '医生办公室',
      activity: '年度体检',
      note: '带上体检报告。',
      personId: 'user113',
    ),
    ScheduleQuery(
      scheduleId: '14',
      startTime: DateTime(2024, 9, 2, 16, 0),
      endTime:  DateTime(2024, 9, 2, 19, 0),
      location: '家里',
      activity: '家庭聚会',
      note: '提前准备。',
      personId: 'user114',
    ),
    ScheduleQuery(
      scheduleId: '15',
      startTime: DateTime(2024, 9, 3, 10, 0),
      endTime: DateTime(2024, 9, 3, 11, 0),
      location: '公司',
      activity: '新项目启动会',
      note: '需要提前准备相关文件。',
      personId: 'user115',
    ),
  ];
}