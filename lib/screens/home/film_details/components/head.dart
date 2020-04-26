// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'package:cinema_app/data/films.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cinema_app/widgets/films/film_banner.dart';

class FilmDetailsHead extends StatelessWidget {
  final Film film;
  final double height;

  FilmDetailsHead({
    this.film,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FilmBanner(
          this.film,
          imageWidth: MediaQuery.of(context).size.width,
          imageHeight: this.height,
          onTap: () async {
            String url = this.film.trailerURL;
            if (await canLaunch(url)) await launch(url);
          },
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: this.height,
          alignment: Alignment.center,
          child: Icon(
            Icons.play_circle_filled,
            size: 50,
            color: Colors.white,
          ),
        ),
        SafeArea(
          minimum: EdgeInsets.only(
              left: 4, top: MediaQuery.of(context).padding.top + 4),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
