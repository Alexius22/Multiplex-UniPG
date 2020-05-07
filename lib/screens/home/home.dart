// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// DB
import 'package:cinema_app/models/film.dart';
import 'package:cinema_app/models/schedule.dart';
import 'package:cinema_app/services/schedules.dart';

// Components
import 'components/datemenu.dart';

// Widgets
import 'package:cinema_app/widgets/loading/loading_screen.dart';
import 'package:cinema_app/widgets/films/film_banner.dart';

// Next page
import 'package:cinema_app/transitions/blank_page_route.dart';
import 'film_details/film_details.dart';

class HomeScreen extends StatefulWidget {
  final String city;
  final FirestoreSchedules schedulesDB = FirestoreSchedules();
  HomeScreen(this.city);

  @override
  State createState() => new _State();
}

class _State extends State<HomeScreen> {
  DateTime _datePicked = DateTime.now();
  List<Film> _films;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Schedule>>(
      future: widget.schedulesDB.fetchSchedules(widget.city),
      builder: (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
        if (!snapshot.hasData) return LoadingScreen();

        final List<Schedule> _schedules = snapshot.data;
        if (_schedules.length == 0 || _schedules == null)
          return Center(
            child: Text(
              "Nessuna programmazione prevista\nper ${widget.city}...",
              textAlign: TextAlign.center,
            ),
          );

        // Schedules are sorted in ascending order, the featured will be the first
        final Film _filmFeatured = _schedules[0].film;
        if (_films == null) _updateFilms(_schedules);
        return Scaffold(
          body: Column(
            children: [
              FilmBanner(
                _filmFeatured,
                imageWidth: MediaQuery.of(context).size.width,
                imageHeight: MediaQuery.of(context).size.height / 4,
                featured: true,
                onTap: () => _onFilmBannerTap(_filmFeatured, _schedules, true),
              ),
              DateMenu(
                onDateChange: (DateTime date) => setState(() {
                  _datePicked = date;
                  _updateFilms(_schedules);
                }),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
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
                      imageHeight: MediaQuery.of(context).size.height / 2.5,
                      onTap: () => _onFilmBannerTap(_films[index], _schedules, false),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(width: MediaQuery.of(context).size.width / 20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _updateFilms(List<Schedule> schedules) {
    final List<Film> _filmTmp = [];
    for (Schedule s in schedules) {
      final sDateTime = s.dateTime;
      // Note: Checking year shouldn't be necessary, but let's play safe
      if (sDateTime.day == _datePicked.day &&
          sDateTime.month == _datePicked.month &&
          sDateTime.year == _datePicked.year) {
        // Check if film wasn't already added (inefficient, an improvement could be to use Sets)
        if (_filmTmp.where((Film f) => f.title == s.film.title).length == 0)
          _filmTmp.add(s.film);
      }
    }
    _films = _filmTmp;
  }

  _onFilmBannerTap(Film film, List<Schedule> schedules, bool featured) {
    // Extract schedules specific of this film
    schedules = schedules.where((Schedule s) => s.film.id == film.id).toList();
    
    // Create film details screen
    var detailPage = FilmDetails(
      film: film,
      schedules: schedules,
      datePicked: _datePicked,
      featured: featured,
    );
    Navigator.push(context, BlankPageRoute(enterPage: detailPage));
  }
}
