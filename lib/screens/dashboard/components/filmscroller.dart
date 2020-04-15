// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import './filmposter.dart';

class FilmScroller extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<FilmScroller> {
  final List<String> entries = <String>[
    'images/captainmarvel.jpg',
    'images/civil.jpg',
    'images/doctorStrange.jpg',
    'images/guardiani.jpg',
    'images/ironman3.jpg',
    'images/wintersoldier.jpg',
    'images/spiderman.jpg',
  ];

  final List<String> entriesText = <String>[
    'Captain Marvel',
    'Captain America: Civil War',
    'Doctor Strange',
    'Guardiani della Galassia',
    'Iron man 3',
    'Captain America: The Winter Soldier',
    'The Amazing Spiderman',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return FilmPoster(imagePath: entries[index], imageText: entriesText[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 20),
      ),
    );
  }
}
