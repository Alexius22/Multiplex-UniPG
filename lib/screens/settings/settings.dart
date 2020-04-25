// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

import 'package:cinema_app/widgets/settings_utility/list_tile_setting.dart';
import 'package:cinema_app/widgets/settings_utility/switch_list_tile_setting.dart';
import 'package:cinema_app/data/cities.dart';

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
          ListTileSetting(
            "Lingua",
            ["Italiano (IT)", "English (EN)", "Japanese (JP)"],
            "Cambiare la lingua comporta un cambio a tutti i testi dell'applicazione.",
          ),
          ListTileSetting(
            "Filtri",
            ["Nessuno", "VM18"],
            "Impostando dei filtri eviterai che ti vengano mostrati determinati film.",
          ),
          SwitchListTileSetting(
            "Dark mode",
            true,
            "La dark mode imposta un tema scuro all'applicazione.",
          ),
          SwitchListTileSetting(
            "Notifiche Push",
            true,
            "Le notifiche push permettono alla app di poterti contattare.",
          ),
        ],
      ),
    );
  }
}
