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

  @override
  Widget build(BuildContext context) {
    // Configuration
    final TextStyle mainStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: MediaQuery.of(context).size.height / 47,
    );
    final TextStyle secondaryStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: MediaQuery.of(context).size.height / 52,
      fontWeight: FontWeight.bold,
      color: Colors.deepOrange[800],
    );
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
          padding: EdgeInsets.all(MediaQuery.of(context).size.height / 160),
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

    Widget _buildTextSection(String title, String body,
        {TextAlign bodyTextAlign = TextAlign.justify}) {
      // Creation
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height / 80),
          Text(
            title,
            style: secondaryStyle,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 300),
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
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 17,
          right: MediaQuery.of(context).size.width / 17),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height / 52),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _genres,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 80),
            Row(
              children: <Widget>[
                // Uscita
                Text(
                  "Uscita:",
                  style: secondaryStyle,
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 50),
                Text(
                  DateFormat('dd/MM/yyyy').format(this.film.releaseDate),
                  style: mainStyle,
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 14),
                // Durata
                Text(
                  "Durata:",
                  style: secondaryStyle,
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 50),
                Text(
                  this.film.durationMins.toString() + "'",
                  style: mainStyle,
                ),
              ],
            ),
            _buildTextSection("Trama:", this.film.plot),
            _buildTextSection("Regia:", this.film.direction.join(', '),
                bodyTextAlign: TextAlign.left),
            _buildTextSection("Cast:", this.film.cast.join(', '),
                bodyTextAlign: TextAlign.left),
            SizedBox(height: this.bottomPadding),
          ],
        ),
      ),
    );
  }
}
