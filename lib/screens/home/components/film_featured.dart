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
                    gradient: LinearGradient(
                      begin: FractionalOffset(0.0, 0.3),
                      end: FractionalOffset(0.0, 1.0),
                      colors: [
                        Theme.of(context).backgroundColor.withOpacity(0.0),
                        Theme.of(context).backgroundColor,
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
                        fontWeight: FontWeight.w600,
                        fontSize: this.textSize / 2.2,
                        letterSpacing: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 50,
                          right: MediaQuery.of(context).size.width / 50,
                          bottom: MediaQuery.of(context).size.height / 52,
                          top: MediaQuery.of(context).size.height / 350),
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
                                fontSize:
                                    MediaQuery.of(context).size.height / 27,
                                height: 1.1,
                                letterSpacing: 3,
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
  }
}
