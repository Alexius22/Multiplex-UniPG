// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'package:cinema_app/models/film.dart';

class FilmBanner extends StatelessWidget {
  final Film film;
  final double imageHeight;
  final double imageWidth;
  final double borderRadius;
  final double textSize;
  final bool featured;
  final bool trailer;
  final Function onTap;

  FilmBanner(
    this.film, {
    this.borderRadius = 15.0,
    this.imageWidth = 150.0,
    this.imageHeight = 180.0,
    this.textSize = 30.0,
    this.featured = false,
    this.trailer = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Discover if image is wanted larger than higher
    final bool imgLargerThanHigher = this.imageWidth > this.imageHeight;

    Widget _heroCustom(String widgetTag, Widget widget) {
      return Hero(
        tag: "$widgetTag-${this.film.id}",
        transitionOnUserGestures: true,
        child: Material(
          type: MaterialType.transparency,
          child: widget,
        ),
      );
    }

    return Container(
      width: this.imageWidth,
      height: this.imageHeight,
      child: Stack(
        children: <Widget>[
          _heroCustom(
            "img",
            ClipRRect(
              borderRadius: BorderRadius.circular(this.borderRadius),
              child: FadeInImage.assetNetwork(
                placeholder: 'images/poster_default.jpg',
                image: this.film.imageURL,
                width: this.imageWidth,
                height: this.imageHeight,
                alignment: imgLargerThanHigher
                    ? Alignment.topCenter
                    : Alignment.center,
                fit: imgLargerThanHigher ? BoxFit.fitWidth : BoxFit.fitHeight,
              ),
            ),
          ),
          _heroCustom(
            "shad",
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(this.borderRadius),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                    Colors.black,
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.0),
                  ],
                  stops: [0.0, 0.7, 1.0],
                ),
              ),
            ),
          ),
          _heroCustom(
            "txt",
            Container(
              alignment: imgLargerThanHigher
                  ? Alignment.bottomCenter
                  : Alignment.bottomLeft,
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // Featured text if wanted
                  if (featured)
                    Text(
                      "In primo piano",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                        fontSize: this.textSize / 2.2,
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                  Text(
                    film.title.toUpperCase(),
                    textAlign:
                        imgLargerThanHigher ? TextAlign.center : TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: this.textSize,
                      height: 1.3,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (this.trailer)
            Center(
              child: Icon(
                Icons.play_circle_filled,
                size: 50,
                color: Colors.white,
              ),
            ),
          // Splash animation
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(this.borderRadius),
              highlightColor: Colors.black26,
              splashColor: Colors.black38,
              onTap: this.onTap,
            ),
          ),
        ],
      ),
    );
  }
}
