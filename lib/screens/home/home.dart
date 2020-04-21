// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'dart:math';
import 'package:flutter/material.dart';

import './components/film_featured.dart';
import './components/datemenu.dart';
import './components/films_scroller.dart';

import 'package:cinema_app/data/films.dart';

class HomeScreen extends StatefulWidget {
  // Get Films data
  final List<Film> filmsData = FilmsData().getAll;
  Film filmFeatured;

  @override
  HomeScreen() {
    final filmFeaturedID = Random().nextInt(filmsData.length);
    filmsData.shuffle();
    filmFeatured = filmsData.removeAt(filmFeaturedID);
  }

  @override
  _State createState() => new _State();
}

class _State extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FeaturedFilm(
            film: widget.filmFeatured,
            imageHeight: MediaQuery.of(context).size.height / 4.05,
          ),
          DateMenu(),
          FilmScroller(
            films: widget.filmsData,
            imageHeight: MediaQuery.of(context).size.height / 2.3,
            textSize: MediaQuery.of(context).size.height / 38,
          ),
        ],
      ),
    );
  }
}
