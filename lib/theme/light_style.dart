// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

ThemeData appLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    // Backgrounds
    backgroundColor: Colors.grey[300],
    scaffoldBackgroundColor: Colors.grey[300],
    bottomAppBarColor: Colors.grey[300],
    canvasColor: Colors.white70,
    // Splashs colors
    highlightColor: Colors.deepOrange[500].withOpacity(0.5),
    splashColor: Colors.deepOrange[900],
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
    // AppBar colors
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: Colors.grey[300],
      elevation: 0.0,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.black87,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    // Switch colors
    toggleableActiveColor: Colors.deepOrange[800],
    // Other colors
    primaryColor: Colors.deepOrange[700],
    disabledColor: Colors.grey[800],
    accentColor: Colors.deepOrange[600],
  );
}
