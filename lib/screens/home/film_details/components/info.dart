// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'package:cinema_app/models/film.dart';
import 'package:intl/intl.dart';

class FilmDetailsInfo extends StatelessWidget {
  final Film film;
  final double height;
  final double bottomPadding;

  FilmDetailsInfo({
    this.film,
    this.height,
    this.bottomPadding,
  });

  // Configuration
  final TextStyle mainStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 17,
  );
  final TextStyle secondaryStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.deepOrange[800],
  );

  @override
  Widget build(BuildContext context) {
    // Internal function to create a button lookalike
    Widget _buildGenre(String label) {
      Color _color = Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[500]
          : Colors.deepOrange[900];

      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: _color,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              color: _color,
            ),
          ),
        ),
      );
    }

    // Build genre widgets
    List<Widget> _genres = [];
    for (String genre in this.film.genres) {
      _genres.add(_buildGenre(genre));
    }

    Widget _buildTextSection(String title, String body, {TextAlign bodyTextAlign=TextAlign.justify}) {
      // Creation
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            title,
            style: secondaryStyle,
          ),
          SizedBox(height: 3),
          Text(
            body,
            textAlign: bodyTextAlign,
            style: mainStyle,
          ),
        ],
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: this.height - 1,
      padding: EdgeInsets.only(left: 25, right: 25),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _genres,
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                // Uscita
                Text(
                  "Uscita:",
                  style: secondaryStyle,
                ),
                SizedBox(width: 8),
                Text(
                  DateFormat('dd/MM/yyyy').format(this.film.releaseDate),
                  style: mainStyle,
                ),
                SizedBox(width: 30),
                // Durata
                Text(
                  "Durata:",
                  style: secondaryStyle,
                ),
                SizedBox(width: 8),
                Text(
                  this.film.durationMins.toString() + "'",
                  style: mainStyle,
                ),
              ],
            ),
            _buildTextSection("Trama:", this.film.plot),
            _buildTextSection("Regia:", this.film.direction.join(', '), bodyTextAlign: TextAlign.left),
            _buildTextSection("Cast:", this.film.cast.join(', '), bodyTextAlign: TextAlign.left),
            SizedBox(height: this.bottomPadding),
          ],
        ),
      ),
    );
  }
}
