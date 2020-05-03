// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

import 'package:cinema_app/services/films.dart';
import './components/datemenu.dart';
import './components/films_scroller.dart';

import 'package:cinema_app/widgets/films/film_banner.dart';
import 'package:cinema_app/transitions/blank_page_route.dart';
import 'film_details/film_details.dart';

class HomeScreen extends StatelessWidget {
  // Get Films data
  final List<Film> filmsData = FilmsData().getAll();

  @override
  Widget build(BuildContext context) {
    void _imageOnTap(film) {
      var detailPage = FilmDetails(film: film);
      Navigator.push(
        context,
        BlankPageRoute(enterPage: detailPage),
      );
    }

    return Container(
      child: Column(
        children: [
          FilmBanner(
            this.filmsData[0],
            imageWidth: MediaQuery.of(context).size.width,
            imageHeight: MediaQuery.of(context).size.height / 4,
            featured: true,
            onTap: () {
              _imageOnTap(this.filmsData[0]);
            },
          ),
          DateMenu(),
          FilmScroller(
            films: this.filmsData.sublist(1),
            imageHeight: MediaQuery.of(context).size.height / 2.3,
            textSize: MediaQuery.of(context).size.height / 38,
          ),
        ],
      ),
    );
  }
}
