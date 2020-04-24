// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

import './login.dart';
import './logged_in.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<ProfileScreen> {
  bool _loggedIn = false;

  @override
  Widget build(BuildContext context) {
    if(_loggedIn)
      return LoggedInScreen(onLogin: _onLogin);
    else
      return LoginScreen(onLogin: _onLogin);
  }

  void _onLogin(bool loggedIn) {
    if (loggedIn) {
      setState(() {
        _loggedIn = true;
      });
    } else {
      setState(() {
        _loggedIn = false;
      });
    }
  }
}
