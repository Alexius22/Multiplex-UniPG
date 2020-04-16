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
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 5),
                child: Text(
                  "Impostazioni",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w600,
                    fontSize: MediaQuery.of(context).size.height / 20,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 100,
          ),
          ListTile(
            title: Text(
              "Lingua",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
            subtitle: Text("Italiano IT",
                style: TextStyle(
                  color: Colors.grey.shade400,
                )),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey.shade400,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Posizione",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
            subtitle: Text("Perugia",
                style: TextStyle(
                  color: Colors.grey.shade400,
                )),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey.shade400,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Filtri",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
            subtitle: Text("Nessuno",
                style: TextStyle(
                  color: Colors.grey.shade400,
                )),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey.shade400,
            ),
            onTap: () {},
          ),
          SwitchListTile(
            title: Text("Vietato Minori",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height / 40,
                )),
            subtitle: Text("Off",
                style: TextStyle(
                  color: Colors.grey.shade400,
                )),
            value: false,
            onChanged: (val) {},
          ),
          SwitchListTile(
            title: Text("Notifiche Push",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height / 40,
                )),
            subtitle: Text("On",
                style: TextStyle(
                  color: Colors.grey.shade400,
                )),
            value: true,
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }
}
