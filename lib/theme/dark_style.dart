// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

ThemeData appDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    // Backgrounds
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    bottomAppBarColor: Colors.black,
    canvasColor: Colors.grey[900],
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.grey[900],
      contentTextStyle: TextStyle(color: Colors.white),
    ),
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
    buttonTheme: ButtonThemeData(
      highlightColor: Colors.deepOrange[500].withOpacity(0.5),
      splashColor: Colors.deepOrange[900],
    ),
    // Tab bar color
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    // AppBar colors
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: Colors.black,
      elevation: 0.0,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white70,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    // Switch colors
    toggleableActiveColor: Colors.deepOrange[800],
    // Other colors
    primaryColor: Colors.deepOrange[700],
    disabledColor: Colors.grey[800],
    accentColor: Colors.deepOrange[600],
  );
}
