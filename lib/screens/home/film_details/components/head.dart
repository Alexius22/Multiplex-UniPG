// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'package:cinema_app/models/film.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cinema_app/widgets/films/film_banner.dart';

class FilmDetailsHead extends StatelessWidget {
  final Film film;
  final double height;
  final bool featured;

  FilmDetailsHead({
    this.film,
    this.height,
    this.featured,
  });

  void _openTrailer() async {
    String url = this.film.trailerURL;
    if (await canLaunch(url)) await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FilmBanner(
          this.film,
          imageWidth: MediaQuery.of(context).size.width,
          imageHeight: this.height,
          featured: featured,
          trailer: true,
          onTap: _openTrailer,
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
