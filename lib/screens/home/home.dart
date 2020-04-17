// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

import './components/film_featured.dart';
import './components/datemenu.dart';
import './components/films_scroller.dart';

import 'package:cinema_app/data/films.dart';

class HomeScreen extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Get Films data
    var filmsData = FilmsData();
    final filmFeaturedID = 0;
    final filmFeatured = filmsData.getAll.removeAt(filmFeaturedID);

    return Container(
      child: Column(
        children: [
          FeaturedFilm(
            film: filmFeatured,
            imageHeight: MediaQuery.of(context).size.height / 4.05,
          ),
          DateMenu(),
          FilmScroller(
            films: filmsData.getAll,
            imageHeight: MediaQuery.of(context).size.height / 2.3,
            textSize: MediaQuery.of(context).size.height / 38,
          ),
        ],
      ),
    );
  }
}
