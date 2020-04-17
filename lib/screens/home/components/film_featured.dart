// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'package:cinema_app/data/films.dart';
import './film_details.dart';
import './blank_page_route.dart';

class FeaturedFilm extends StatelessWidget {
  final Film film;
  final double imageHeight;
  final double textSize;

  FeaturedFilm({
    this.film,
    this.imageHeight = 180,
    this.textSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var detailPage = FilmDetails(film: film);
        Navigator.push(context, BlankPageRoute(enterPage: detailPage));
      },
      child: Stack(
        children: <Widget>[
          // Image with gradient
          Container(
            width: double.infinity,
            height: this.imageHeight,
            child: Ink.image(
              alignment: Alignment.center,
              image: AssetImage(
                film.imagePath,
              ),
              fit: BoxFit.fitWidth,
              child: InkWell(
                highlightColor: Colors.black38,
                splashColor: Colors.black38,
                onTap: () {
                  var detailPage = FilmDetails(film: film);
                  Navigator.push(
                      context, BlankPageRoute(enterPage: detailPage));
                },
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.black,
                ],
                stops: [0.2, 1.0],
              ),
            ),
          ),
          // Featured Text
          Container(
            width: MediaQuery.of(context).size.width,
            height: this.imageHeight,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: this.textSize + 22),
            child: Text(
              "In primo piano",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'OpenSans',
                package: 'cinema-app',
                color: Colors.white,
                fontSize: this.textSize / 2.2,
                letterSpacing: 1,
              ),
            ),
          ),
          // Text
          Container(
            width: MediaQuery.of(context).size.width,
            height: this.imageHeight,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              this.film.title.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: this.textSize,
                letterSpacing: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
