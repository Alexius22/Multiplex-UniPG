// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// DB
import 'package:cinema_app/models/film.dart';
import 'package:cinema_app/models/schedule.dart';
import 'package:cinema_app/services/schedules.dart';

// Widgets
import 'package:cinema_app/widgets/loading/loading_screen.dart';
import 'package:cinema_app/widgets/films/film_banner.dart';

// Next page
import 'package:cinema_app/transitions/blank_page_route.dart';
import 'film_details/film_details.dart';

class HomeScreen extends StatelessWidget {
  final String city;
  HomeScreen(this.city);

  final FirestoreSchedules schedulesDB = FirestoreSchedules();

  @override
  Widget build(BuildContext context) {
    // Calculate vertical space not considering appbar and bottom navbar
    final verticalSpaceAvailable = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight -
        65;

    // No city selected (first time user?)
    if (city == null)
      return Scaffold(body: Center(child: Text("Seleziona una città...")));

    return FutureBuilder<List<Schedule>>(
      future: schedulesDB.fetchSchedules(city),
      builder: (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
        if (!snapshot.hasData) return LoadingScreen();

        final List<Schedule> _schedules = snapshot.data;

        // No film scheduled (coronavirus?)
        if (_schedules.length == 0 || _schedules == null)
          return Center(
            child: Text(
              "Nessuna programmazione prevista\nper $city...",
              textAlign: TextAlign.center,
            ),
          );

        // Extract films from schedules
        final Set<String> _filmIDs = Set<String>();
        final List<Film> _films = _schedules
            .where((Schedule s) => _filmIDs.add(s.film.id))
            .map((Schedule s) => s.film)
            .toList();

        // Note: schedules are sorted in ascending order, the featured will be the first
        final Film _filmFeatured = _films[0];
        _films.removeAt(0);

        // Build GUI
        return Scaffold(
          body: Column(
            children: [
              // Featured film (first film in chronological order)
              FilmBanner(
                _filmFeatured,
                imageWidth: MediaQuery.of(context).size.width,
                imageHeight: verticalSpaceAvailable / 3,
                featured: true,
                onTap: () =>
                    _onFilmBannerTap(context, _filmFeatured, _schedules),
              ),
              // Text info for the user
              SizedBox(
                height: verticalSpaceAvailable / 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Film in ",
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: MediaQuery.of(context).size.height / 38,
                      ),
                    ),
                    Text(
                      "PROGRAMMAZIONE",
                      style: TextStyle(
                        fontFamily: 'Oswald',
                        fontSize: MediaQuery.of(context).size.height / 32,
                        letterSpacing: 2,
                        color: Colors.deepOrange[800],
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.query_builder,
                      size: MediaQuery.of(context).size.height / 28,
                    ),
                  ],
                ),
              ),
              // All other films
              if (_films.length == 0)
                Text("Non ci sono altri film in programmazione...")
              else
                Container(
                  height: verticalSpaceAvailable * 5 / 9,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 17,
                      right: MediaQuery.of(context).size.width / 17,
                    ),
                    itemCount: _films.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FilmBanner(
                        _films[index],
                        textSize: MediaQuery.of(context).size.height / 38,
                        imageWidth: 150,
                        imageHeight: verticalSpaceAvailable * 5 / 9,
                        onTap: () => _onFilmBannerTap(
                            context, _films[index], _schedules),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(width: MediaQuery.of(context).size.width / 20),
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  _onFilmBannerTap(BuildContext context, Film film, List<Schedule> schedules) {
    // Extract schedules specific of this film
    schedules = schedules.where((Schedule s) => s.film.id == film.id).toList();

    // Create film details screen
    var detailPage = FilmDetails(
      film: film,
      schedules: schedules,
    );
    Navigator.push(context, BlankPageRoute(enterPage: detailPage));
  }
}
