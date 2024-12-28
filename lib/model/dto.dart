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
class ScheduleQuery {
  String? scheduleId;
  DateTime? startTime;
  DateTime? endTime;
  String? location;
  String? activity;
  String? note; // 使用 String? 表示 note 可以为空
  String? personId; // 使用 String? 表示 personId 可以为空

  ScheduleQuery({
    this.scheduleId,
    this.startTime,
    this.endTime,
    this.location,
    this.activity,
    this.note,
    this.personId,
  });

  // 方便打印的 toString 方法
  @override
  String toString() {
    return 'ScheduleQuery('
        'scheduleId: $scheduleId, '
        'startTime: $startTime, '
        'endTime: $endTime, '
        'location: $location, '
        'activity: $activity, '
        'note: $note, '
        'personId: $personId'
        ')';
  }
  // 将ScheduleQuery对象转换为Map, 用于json
  Map<String, dynamic> toJson() {
    return {
      'scheduleId': scheduleId,
      'startTime': startTime!.toIso8601String(),
      'endTime': endTime!.toIso8601String(),
      'location': location,
      'activity': activity,
      'note': note,
      'personId': personId,
    };
  }

  // 将 Map 转换为 ScheduleQuery 对象
  factory ScheduleQuery.fromJson(Map<String, dynamic> json) {
    return ScheduleQuery(
      scheduleId: json['scheduleId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      location: json['location'],
      activity: json['activity'],
      note: json['note'],
      personId: json['personId'],
    );
  }
}