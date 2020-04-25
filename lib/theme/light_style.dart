// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

ThemeData appLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    // Backgrounds
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    bottomAppBarColor: Colors.white,
    canvasColor: Colors.white70,
    // Splashs colors
    highlightColor: Colors.deepOrange[500].withOpacity(0.5),
    splashColor: Colors.deepOrange[900],
    // Other colors
    disabledColor: Colors.grey[800],
    accentColor: Colors.deepOrange[600],
    // Button text color
    buttonColor: Colors.deepOrange[900],
    textTheme: TextTheme(
      button: TextStyle(
        color: Colors.white,
      ),
    ),
    // Tab bar color
    tabBarTheme: TabBarTheme(
      labelColor: Colors.black,
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.black,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.black87,
        ),
      ),
    ),
  );
}
