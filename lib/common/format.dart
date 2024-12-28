import 'package:intl/intl.dart';

String text(
    Map obj,
    String field, {
      String defaultText = '',
      String suffix = '',
      int startIndex = -1,
      int endIndex = -1,
    }) {
  String ret = (obj[field] ?? defaultText).toString();
  if (ret == '') {
    return ret;
  }
  if (startIndex != -1 && endIndex != -1) {
    ret = ret.substring(startIndex, endIndex);
  }
  ret += suffix;
  return ret;
}

String yearAndMonth(String date) {
  final regex = RegExp(r'^(\d{4})\.(\d{2})$');
  final match = regex.firstMatch(date);
  if (match != null) {
    final year = match.group(1);
    final month = match.group(2);
    return '$year-$month-01';
  }
  return date;
}

String age({
  DateTime? birthdate,
  String? unit,
}) {
  if (birthdate == null) {
    return '';
  }
  DateTime today = DateTime.now();
  int age = today.year - birthdate.year;

  // 检查是否已经过了生日，若还没过则减1
  if (today.month < birthdate.month ||
      (today.month == birthdate.month && today.day < birthdate.day)) {
    age--;
  }
  if (unit == null) {
    return age.toString();
  }
  return age.toString() + unit;
}

String birthFromIdCard(String idCard) {
  String date = idCard.substring(6, 14);
  String year = idCard.substring(6, 10);
  String month = idCard.substring(10, 12);
  String day = idCard.substring(12, 14);
  return year + "-" + month + "-" + day;
}

String genderFromIdCard(String idCard) {
  return (int.parse(idCard.substring(16, 17)) % 2 == 1) ? '0' : '1';
}

String timeAgo(DateTime? date) {
  if (date == null) {
    return '';
  }
  int mins = DateTime.now().difference(date).inMinutes;
  if (mins <= 2) {
    return '刚刚';
  }
  if (mins < 60) {
    return mins.toString() + '分钟前';
  }
  int hours = DateTime.now().difference(date).inHours;
  if (hours < 24) {
    return hours.toString() + '小时前';
  }
  return DateFormat('yyyy-MM-dd hh:mm').format(date);
}

String yearAndMonth4Chinese(DateTime date) {
  return DateFormat('yyyy年M月').format(date);
}
