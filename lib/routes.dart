// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/widgets.dart';
import 'package:cinema_app/screens/dashboard/dashboard.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/home': (BuildContext context) => DashboardScreen(),
  /*
  '/': (BuildContext context) => Choice(),
  '/film': (BuildContext context) => FilmDetails(),
  '/checkout': (BuildContext context) => Checkout(),
  '/tickets': (BuildContext context) => Tickets(),
  '/settings': (BuildContext context) => Settings(),
  '/settings/profile': (BuildContext context) => Profile(),
  */
};