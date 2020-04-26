// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchListTileSetting extends StatefulWidget {
  final String textTitle;
  final bool defaultState;
  final String hint;
  final Function fun;

  SwitchListTileSetting(this.textTitle, this.defaultState, this.hint, {this.fun});

  @override
  _State createState() => new _State();
}

class _State extends State<SwitchListTileSetting> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> _currentOption;

  @override
  void initState() {
    _currentOption = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool(widget.textTitle) ?? widget.defaultState;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _currentOption,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading...");
        } else {
          return Tooltip(
            message: widget.hint,
            child: SwitchListTile(
              title: Text(
                widget.textTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height / 40,
                ),
              ),
              subtitle: Text(
                snapshot.data ? 'On' : 'Off',
                style: TextStyle(
                  color:
                      Theme.of(context).textTheme.title.color.withOpacity(0.5),
                ),
              ),
              value: snapshot.data,
              onChanged: (val) async {
                if (widget.fun != null) widget.fun(val);
                // Update preferences
                final SharedPreferences prefs = await _prefs;
                setState(() {
                  _currentOption =
                      prefs.setBool(widget.textTitle, val).then((bool success) {
                    return val;
                  });
                });
              },
            ),
          );
        }
      },
    );
  }
}
