// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'package:cinema_app/theme/dark_style.dart';
import 'package:cinema_app/theme/light_style.dart';
import 'package:cinema_app/navbar.dart';
import 'package:cinema_app/routes.dart';

void main() => runApp(CinemaApp());

class CinemaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema App',
      debugShowCheckedModeBanner: false,
      theme: appLightTheme(),
      darkTheme: appDarkTheme(),
      home: BubbleTabBar(),
      routes: routes,
    );
  }
}
