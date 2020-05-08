// Copyright 2020 Amatucci & Strippoli. All rights reserved.
import 'package:intl/intl.dart';

String formatDate(DateTime date, {extended: false}) {
  if (extended)
    return DateFormat('EEEE dd/MM', 'it').format(date);
  else
    return DateFormat('dd/MM', 'it').format(date);
}

String formatTime(DateTime time) {
  return "${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}";
}

DateTime formatTimeReverse(String s) {
  List<String> _tmp = s.split(':');
  return DateTime(2020, 1, 1, int.parse(_tmp[0]), int.parse(_tmp[1]));
}

String formatSeat(int x, int y) {
  return "${String.fromCharCode(65 + y)}${x + 1}";
}
