// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

import 'package:cinema_app/transitions/blank_page_route.dart';
import 'package:cinema_app/data/films.dart';
import '../film_details/film_details.dart';

class FilmPoster extends StatelessWidget {
  final Film film;
  final double textSize;
  final double imageHeight;
  final double imageWidth;

  FilmPoster({
    this.film,
    this.imageWidth = 150,
    this.imageHeight = 250,
    this.textSize = 18,
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
                  width: this.imageWidth,
                  height: this.imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(film.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Hero(
                tag: "film-shadow" + film.id.toString(),
                child: Container(
                  width: this.imageWidth,
                  height: this.imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
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
              Hero(
                tag: "film-title" + film.id.toString(),
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    width: this.imageWidth,
                    height: this.imageHeight,
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 40,
                        right: MediaQuery.of(context).size.width / 40,
                        bottom: MediaQuery.of(context).size.height / 52),
                    child: Text(
                      film.title.toUpperCase(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: this.textSize,
                        height: MediaQuery.of(context).size.height / 680,
                        fontFamily: 'Oswald',
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
