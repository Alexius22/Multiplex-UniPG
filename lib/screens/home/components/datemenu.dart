// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

class DateMenu extends StatefulWidget {
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
  DateTime minDate = DateTime.now().add(new Duration(days: 2));

  void _pressButton(int i) {
    setState(() {
      pressedButtons = List.filled(3, false);
      pressedButtons[i] = true;
      if(i==2)
        _selectDate();
    });
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: minDate,
      firstDate: minDate.subtract(new Duration(days: 1)),
      lastDate: minDate.add(new Duration(days: 13)),
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
      _pressButton(2);
      setState(() => _selectedDate =
          picked.day.toString() + "/" + picked.month.toString());
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
        /*
        FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          color: pressedButtons[2] ? Colors.deepOrange[900] : Colors.black,
          splashColor: Colors.deepOrange[300],
          textColor: Colors.white,
          child: Text(
            _selectedDate,
            style: TextStyle(fontSize: MediaQuery.of(context).size.height / 40),
          ),
          onPressed: _selectDate,
        ),*/
      ],
    );
  }

  Widget _dateButton(press, text) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 26,
          right: MediaQuery.of(context).size.width / 26,
          top: MediaQuery.of(context).size.height / 80,
          bottom: MediaQuery.of(context).size.height / 80),
      color: pressedButtons[press] ? Colors.deepOrange[900] : Colors.black,
      splashColor: Colors.deepOrange[300],
      textColor: Colors.white,
      child: Text(
        text,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height / 40,
        ),
      ),
      onPressed: () {
        _pressButton(press);
      },
    );
  }
}
