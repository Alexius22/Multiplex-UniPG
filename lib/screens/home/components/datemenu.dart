// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// Utils
import 'package:cinema_app/utils/calendar.dart';
import 'package:cinema_app/utils/format.dart';

class DateMenu extends StatefulWidget {
  final DateTime minDate = DateTime.now();
  final DateTime maxDate = DateTime.now().add(Duration(days: 14));

  @override
  _State createState() => new _State();
}

class _State extends State<DateMenu> {
  List<bool> pressedButtons = <bool>[
    true,
    false,
    false,
  ];
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      buttonPadding: EdgeInsets.only(left: 10, right: 10),
      children: <Widget>[
        _dateButton(0, "Oggi"),
        _dateButton(1, "Domani"),
        _dateButton(2, formatDate(_selectedDate, 'Altra data')),
      ],
    );
  }

  Widget _dateButton(id, text) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: pressedButtons[id]
          ? Theme.of(context).buttonColor
          : Theme.of(context).backgroundColor,
      highlightColor: Theme.of(context).highlightColor,
      splashColor: Theme.of(context).splashColor,
      child: Text(
        text,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height / 38,
          fontWeight: FontWeight.bold,
          color: pressedButtons[id]
              ? Theme.of(context).textTheme.button.color
              : Theme.of(context).textTheme.title.color,
        ),
      ),
      onPressed: () {
        _pressButton(id);
      },
    );
  }

  void _pressButton(int i) {
    if (i != 2) {
      setState(() {
        // Select active button & resetting defaults
        // Resetting defaults
        pressedButtons = List.filled(3, false);
        pressedButtons[i] = true;
        _selectedDate = null;
      });
    } else
      _selectDate();
  }

  void _selectDate() async {
    DateTime _picked = await selectDate(
      context: context,
      currentDate: _selectedDate,
      firstDate: widget.minDate,
      lastDate: widget.maxDate,
      unselectableDays: [],
    );
    if (_picked != null) {
      setState(() {
        pressedButtons = List.filled(3, false);
        pressedButtons[2] = true;
        _selectedDate = _picked;
      });
    }
  }
}
