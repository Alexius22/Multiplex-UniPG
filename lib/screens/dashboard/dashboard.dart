// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import './components/topimage.dart';
import './components/datemenu.dart';
import './components/filmscroller.dart';

class Dashboard extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TopImage(imageHeight: MediaQuery.of(context).size.height / 4.1),
          DateMenu(),
          FilmScroller(),
        ],
      ),
    );
  }
}
