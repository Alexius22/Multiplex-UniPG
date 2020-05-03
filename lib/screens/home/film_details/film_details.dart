// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'package:cinema_app/services/films.dart';

// Components
import 'components/head.dart';
import 'components/footer.dart';
import 'components/info.dart';

class FilmDetails extends StatelessWidget {
  final Film film;

  FilmDetails({
    this.film,
  });

  @override
  Widget build(BuildContext context) {
    // Configuration
    final headHeight = MediaQuery.of(context).size.height / 4 +
        AppBar().preferredSize.height +
        MediaQuery.of(context).padding.top;
    final footerHeight = 50.0;
    final footerBottomPadding = 15.0;

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
                bottomPadding: 45.0,
              ),
            ],
          ),
          FilmDetailsFooter(
            film: this.film,
            height: footerHeight,
            gradientHeight: 45.0,
            bottomPadding: footerBottomPadding,
          ),
        ],
      ),
    );
  }
}
