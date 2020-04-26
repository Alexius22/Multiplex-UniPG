// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

import 'package:cinema_app/data/films.dart';

import 'package:cinema_app/widgets/films/film_banner.dart';
import 'package:cinema_app/transitions/blank_page_route.dart';
import '../film_details/film_details.dart';

class FilmScroller extends StatelessWidget {
  final List<Film> films;
  final double imageHeight;
  final double textSize;

  FilmScroller({
    this.films,
    this.imageHeight = 180,
    this.textSize = 30,
  });

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
      height: this.imageHeight,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 17,
            right: MediaQuery.of(context).size.width / 17,
            top: MediaQuery.of(context).size.height / 80),
        itemCount: this.films.length,
        itemBuilder: (BuildContext context, int index) {
          return FilmBanner(
            this.films[index],
            textSize: this.textSize,
            imageWidth: 150,
            imageHeight: this.imageHeight,
            onTap: () {
              _imageOnTap(this.films[index]);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: MediaQuery.of(context).size.width / 20),
      ),
    );
  }
}
