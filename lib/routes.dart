// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/widgets.dart';
import 'package:cinema_app/screens/dashboard.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/main': (BuildContext context) => Dashboard(),
  /*
  '/': (BuildContext context) => Choice(),
  '/film': (BuildContext context) => FilmDetails(),
  '/checkout': (BuildContext context) => Checkout(),
  '/tickets': (BuildContext context) => Tickets(),
  '/profile': (BuildContext context) => Profile(),
  '/settings': (BuildContext context) => Settings(),
  */
};