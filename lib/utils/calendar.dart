// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

Future<DateTime> selectDate({
  @required BuildContext context,
  @required DateTime currentDate,
  @required DateTime firstDate,
  @required DateTime lastDate,
  List<DateTime> unselectableDays,
}) async {
  return await showDatePicker(
    context: context,
    initialDate: currentDate != null ? currentDate : firstDate,
    firstDate: firstDate.subtract(new Duration(days: 1)),
    lastDate: lastDate,
    selectableDayPredicate: (DateTime datetime) {
      for (DateTime un in unselectableDays)
        if (un.day == datetime.day && un.month == datetime.month) return false;
      return true;
    },
    builder: (BuildContext context, Widget child) {
      if (Theme.of(context).brightness == Brightness.dark)
        return Theme(
          data: ThemeData.dark().copyWith(
            backgroundColor: Colors.grey[800],
            dialogBackgroundColor: Colors.grey[900],
            accentColor: Colors.deepOrange[600],
          ),
          child: child,
        );
      else
        return Theme(
          data: ThemeData.light().copyWith(
            accentColor: Colors.deepOrange[600],
            primaryColor: Colors.deepOrange[900],
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.accent,
              colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.deepOrange[900],
              ),
            ),
          ),
          child: child,
        );
    },
  );
}
