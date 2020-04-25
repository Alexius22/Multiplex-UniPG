// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 100,
          ),
          _listDrop("Lingua", "Italiano IT"),
          _listDrop("Posizione", "Perugia (PG)"),
          _listDrop("Filtri", "Nessuno"),
          _listButton("Vietato Minori", "Off", false),
          _listButton("Notifiche Push", "On", true),
        ],
      ),
    );
  }

  Widget _listDrop(primary, secondary) {
    return ListTile(
      title: Text(
        primary,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height / 40,
        ),
      ),
      subtitle: Text(secondary,
          style: TextStyle(
            color: Theme.of(context).textTheme.title.color.withOpacity(0.5),
          )),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Theme.of(context).textTheme.title.color.withOpacity(0.5),
      ),
      onTap: () {},
    );
  }

  Widget _listButton(primary, secondary, val) {
    return SwitchListTile(
      title: Text(primary,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.height / 40,
          )),
      subtitle: Text(secondary,
          style: TextStyle(
            color: Theme.of(context).textTheme.title.color.withOpacity(0.5),
          )),
      value: val,
      onChanged: (val) {},
    );
  }
}
