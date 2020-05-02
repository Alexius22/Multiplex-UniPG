// Copyright 2020 Amatucci & Strippoli. All rights reserved.

String formatDate(DateTime date, String onNull) {
  if (date != null) return "${date.day}/${date.month}";
  return onNull;
}

String formatTime(DateTime time, String onNull) {
  if (time != null) return "${time.hour}:${time.minute}";
  return onNull;
}

String formatSeat(int x, int y) {
  return "${String.fromCharCode(64 + x)}$y";
}
