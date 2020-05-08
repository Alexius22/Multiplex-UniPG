// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// DB
import 'package:cinema_app/models/film.dart';
import 'package:cinema_app/models/schedule.dart';

// Components
import 'components/head.dart';
import 'components/footer.dart';
import 'components/info.dart';

class FilmDetails extends StatelessWidget {
  final Film film;
  final List<Schedule> schedules;

  FilmDetails({
    this.film,
    this.schedules,
  });

  @override
  Widget build(BuildContext context) {
    // Configuration
    final headHeight = (MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).size.height / 12) /
            3 +
        AppBar().preferredSize.height +
        MediaQuery.of(context).padding.top;
    final footerHeight = MediaQuery.of(context).size.height / 6;
    final footerBottomPadding = MediaQuery.of(context).size.height / 53;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // Build head with trailer link and back button
              FilmDetailsHead(
                film: this.film,
                height: headHeight,
              ),
              // Build film's info (genres, plot, cast...)
              FilmDetailsInfo(
                film: this.film,
                // Fill all the height except for the space for head and footer
                height: MediaQuery.of(context).size.height -
                    headHeight -
                    footerHeight -
                    footerBottomPadding,
                // Provide a bottom padding to avoid gradient
                bottomPadding: MediaQuery.of(context).size.height / 27,
              ),
            ],
          ),
          // Build buy ticket button
          FilmDetailsFooter(
            film: this.film,
            schedules: this.schedules,
            height: footerHeight,
            gradientHeight: MediaQuery.of(context).size.height / 18,
            bottomPadding: footerBottomPadding,
          ),
        ],
      ),
    );
  }
}
