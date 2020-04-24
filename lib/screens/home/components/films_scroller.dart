// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

import 'package:cinema_app/data/films.dart';
import './film_poster.dart';

class FilmScroller extends StatefulWidget {
  final List<Film> films;
  final double imageHeight;
  final double textSize;

  FilmScroller({
    this.films,
    this.imageHeight = 180,
    this.textSize = 30,
  });

  @override
  _State createState() => new _State(
        films: this.films,
        imageHeight: this.imageHeight,
        textSize: this.textSize,
      );
}

class _State extends State<FilmScroller> {
  final List<Film> films;
  final double imageHeight;
  final double textSize;

  _State({
    this.films,
    this.imageHeight = 180,
    this.textSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.imageHeight,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 17,
            right: MediaQuery.of(context).size.width / 17,
            top: MediaQuery.of(context).size.height / 80),
        itemCount: films.length,
        itemBuilder: (BuildContext context, int index) {
          return FilmPoster(
            film: films[index],
            textSize: textSize,
            imageHeight: this.imageHeight,
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: MediaQuery.of(context).size.width / 20),
      ),
    );
  }
}
