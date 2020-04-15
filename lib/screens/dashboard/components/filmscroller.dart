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
    final double height = MediaQuery.of(context).size.height / 2.3;
    final double textSize = MediaQuery.of(context).size.height / 38;

    return Container(
      height: height,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return FilmPoster(
            imagePath: entries[index],
            imageText: entriesText[index],
            textSize: textSize,
            imageHeight: height,
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 20),
      ),
    );
  }
}
