// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'setting_selection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cinema_app/transitions/slide_left_route.dart';

class ListTileSetting extends StatefulWidget {
  final String textTitle;
  final List<String> options;
  final String hint;

  ListTileSetting(this.textTitle, this.options, this.hint);

  @override
  _State createState() => new _State();
}

class _State extends State<ListTileSetting> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> _currentOption;

  @override
  void initState() {
    _currentOption = _prefs.then((SharedPreferences prefs) {
      return prefs.getString(widget.textTitle) ?? widget.options[0];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _currentOption,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading...");
        } else {
          return Tooltip(
            message: widget.hint,
            child: ListTile(
              title: Text(
                widget.textTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height / 40,
                ),
              ),
              subtitle: Text(
                snapshot.data,
                style: TextStyle(
                  color:
                      Theme.of(context).textTheme.title.color.withOpacity(0.5),
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Theme.of(context).textTheme.title.color.withOpacity(0.5),
              ),
              onTap: () async {
                // Update preferences
                await Navigator.push(
                  context,
                  SlideLeftRoute(
                    page: SettingSelection(
                        widget.textTitle, widget.options, snapshot.data),
                  ),
                );
                setState(() {
                  _currentOption = _prefs.then((SharedPreferences prefs) {
                    return prefs.getString(widget.textTitle) ??
                        widget.options[0];
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
