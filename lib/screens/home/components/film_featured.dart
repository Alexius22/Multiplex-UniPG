// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'package:cinema_app/data/films.dart';
import 'package:cinema_app/transitions/blank_page_route.dart';
import '../film_details/film_details.dart';

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
          Stack(
            children: <Widget>[
              Hero(
                tag: "film-image" + film.id.toString(),
                child: Container(
                  width: double.infinity,
                  height: this.imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: AssetImage(film.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Hero(
                tag: "film-shadow" + film.id.toString(),
                child: Container(
                  width: double.infinity,
                  height: this.imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    gradient: LinearGradient(
                      begin: FractionalOffset(0.0, 0.3),
                      end: FractionalOffset(0.0, 1.0),
                      colors: [
                        Colors.black.withOpacity(0.0),
                        Colors.black,
                      ],
                      stops: [0.0, 1.0],
                    ),
                  ),
                ),
              ),
              // Text
              Container(
                height: this.imageHeight,
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
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
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 15, top: 2),
                      child: Hero(
                        tag: "film-title" + this.film.id.toString(),
                        child: Material(
                          type: MaterialType.transparency,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              this.film.title.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 30,
                                height: 1.1,
                                letterSpacing: 3,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    /*
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
    */
  }
}
