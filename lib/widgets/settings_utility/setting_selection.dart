// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cinema_app/transitions/slide_left_route.dart';

class SettingSelection extends StatefulWidget {
  final String textTitle;
  final List<String> options;
  final String currentOption;

  SettingSelection(this.textTitle, this.options, this.currentOption);

  @override
  _State createState() => new _State();
}

class _State extends State<SettingSelection> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> _currentOption;

  @override
  void initState() {
    _currentOption = _prefs.then((SharedPreferences prefs) {
      return prefs.getString(widget.textTitle) ?? widget.currentOption;
    });
    super.initState();
  }

  Future<void> _saveSetting(String opt) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _currentOption =
          prefs.setString(widget.textTitle, opt).then((bool success) {
        return opt;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Scegli un'opzione",
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.height / 30,
            color: Theme.of(context).textTheme.title.color,
          ),
        ),
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(20),
        itemCount: widget.options.length,
        itemBuilder: (BuildContext context, int i) {
          return FutureBuilder<String>(
            future: _currentOption,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading...");
              } else {
                return ListTile(
                  title: Text(
                    widget.options[i],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height / 40,
                    ),
                  ),
                  selected: snapshot.data == widget.options[i],
                  trailing: snapshot.data == widget.options[i]
                      ? Icon(Icons.check)
                      : null,
                  onTap: () {
                    _saveSetting(widget.options[i]);
                  },
                );
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Theme.of(context).textTheme.title.color.withOpacity(0.3),
          thickness: 1,
          height: 0,
        ),
      ),
    );
  }
}
