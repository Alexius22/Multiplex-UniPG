// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// Utils
import 'package:cinema_app/utils/calendar.dart';
import 'package:cinema_app/utils/format.dart';

class DateMenu extends StatefulWidget {
  final DateTime minDate = DateTime.now();
  final DateTime maxDate = DateTime.now().add(Duration(days: 14));
  final Function onDateChange;
  DateMenu({this.onDateChange});

  @override
  _State createState() => new _State();
}

class _State extends State<DateMenu> {
  List<bool> buttonsStatus = <bool>[
    true,
    false,
    false,
  ];
  DateTime _calendarDate;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      buttonPadding: EdgeInsets.only(left: 10, right: 10),
      children: <Widget>[
        _dateButton(0, "Oggi"),
        _dateButton(1, "Domani"),
        _dateButton(2, formatDate(_calendarDate, 'Altra data')),
      ],
    );
  }

  Widget _dateButton(id, text) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: buttonsStatus[id]
          ? Theme.of(context).buttonColor
          : Theme.of(context).backgroundColor,
      highlightColor: Theme.of(context).highlightColor,
      splashColor: Theme.of(context).splashColor,
      child: Text(
        text,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height / 38,
          fontWeight: FontWeight.bold,
          color: buttonsStatus[id]
              ? Theme.of(context).textTheme.button.color
              : Theme.of(context).textTheme.title.color,
        ),
      ),
      onPressed: () {
        _pressButton(id);
      },
    );
  }

  void _pressButton(int i) async {
    if (i != 2) {
      setState(() {
        // Select active button & resetting defaults
        buttonsStatus = List.filled(3, false);
        _calendarDate = null;
        buttonsStatus[i] = true;
        if (i == 0)
          widget.onDateChange(DateTime.now());
        else
          widget.onDateChange(DateTime.now().add(Duration(days: 1)));
      });
    } else {
      DateTime _picked = await selectDate(
        context: context,
        currentDate: _calendarDate,
        firstDate: widget.minDate,
        lastDate: widget.maxDate,
        unselectableDays: [],
      );
      if (_picked != null) {
        setState(() {
          buttonsStatus = List.filled(3, false);
          buttonsStatus[2] = true;
          _calendarDate = _picked;
          widget.onDateChange(_picked);
        });
      }
    }
  }
}
