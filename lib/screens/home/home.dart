// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// DB
import 'package:cinema_app/models/film.dart';
import 'package:cinema_app/models/schedule.dart';
import 'package:cinema_app/services/films.dart';

// Widgets
import 'package:cinema_app/widgets/loading/loading_screen.dart';
import 'components/datemenu.dart';
import 'components/films_scroller.dart';
import 'package:cinema_app/widgets/films/film_banner.dart';

// Next page
import 'package:cinema_app/transitions/blank_page_route.dart';
import 'film_details/film_details.dart';

class HomeScreen extends StatefulWidget {
  final String city;
  HomeScreen(this.city);

  @override
  State createState() => new _State();
}

class _State extends State<HomeScreen> {
  DateTime _dateSelected;
  List<Schedule> _schedules;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Film>>(
      future: FirestoreFilms().fetchFilms(),
      builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
        if (!snapshot.hasData)
          return LoadingScreen();
        final _films = snapshot.data;
        return Container(
          child: Column(
            children: [
              FilmBanner(
                _films[0],
                imageWidth: MediaQuery.of(context).size.width,
                imageHeight: MediaQuery.of(context).size.height / 4,
                featured: true,
                onTap: () {
                  var detailPage = FilmDetails(
                    film: _films[0],
                    schedules: _schedules,
                    dateSelected: _dateSelected,
                  );
                  Navigator.push(
                      context, BlankPageRoute(enterPage: detailPage));
                },
              ),
              DateMenu(),
              FilmScroller(
                films: _films.sublist(1),
                imageHeight: MediaQuery.of(context).size.height / 2.5,
                textSize: MediaQuery.of(context).size.height / 38,
              ),
            ],
          ),
        );
      },
    );
  }
}
