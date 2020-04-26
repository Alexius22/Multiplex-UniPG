// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

class DateMenu extends StatefulWidget {
  final DateTime minDate = DateTime.now().add(new Duration(days: 2));

  @override
  _State createState() => new _State();
}

class _State extends State<DateMenu> {
  List<bool> pressedButtons = <bool>[
    true,
    false,
    false,
  ];
  String _selectedDate = 'Altra data';

  void _pressButton(int i) {
    if (i != 2) {
      setState(() {
        // Select active button
        // Resetting defaults
        pressedButtons = List.filled(3, false);
        _selectedDate = 'Altra data';
        pressedButtons[i] = true;
      });
    } else
      _selectDate();
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: widget.minDate,
      firstDate: widget.minDate.subtract(new Duration(days: 1)),
      lastDate: widget.minDate.add(new Duration(days: 13)),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            backgroundColor: Colors.grey[800],
            dialogBackgroundColor: Colors.grey[900],
            accentColor: Colors.grey[700],
          ),
          child: child,
        );
      },
    );
    if (picked != null) {
      setState(() {
        pressedButtons = List.filled(3, false);
        pressedButtons[2] = true;
        _selectedDate = picked.day.toString() + "/" + picked.month.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        _dateButton(0, "Oggi"),
        _dateButton(1, "Domani"),
        _dateButton(2, _selectedDate),
      ],
    );
  }

  Widget _dateButton(id, text) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 26,
        right: MediaQuery.of(context).size.width / 26,
        top: MediaQuery.of(context).size.height / 80,
        bottom: MediaQuery.of(context).size.height / 80,
      ),
      color: pressedButtons[id]
          ? Theme.of(context).buttonColor
          : Theme.of(context).backgroundColor,
      highlightColor: Theme.of(context).highlightColor,
      splashColor: Theme.of(context).splashColor,
      child: Text(
        text,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height / 40,
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
}
