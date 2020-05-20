// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

Future<DateTime> selectDate({
  @required BuildContext context,
  @required DateTime currentDate,
  List<DateTime> selectableDays,
}) async {
  // Sort and remove invalid selectable days
  selectableDays.sort();

  // Show calendar
  return await showDatePicker(
    context: context,
    initialDate: currentDate != null ? currentDate : selectableDays[0],
    firstDate: DateTime.now(),
    lastDate: selectableDays.last,
    selectableDayPredicate: (DateTime datetime) {
      for (DateTime sel in selectableDays)
        if (sel.day == datetime.day && sel.month == datetime.month) return true;
      return false;
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
