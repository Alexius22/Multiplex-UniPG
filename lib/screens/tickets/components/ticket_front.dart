// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cinema_app/data/tickets.dart';
import 'package:cinema_app/data/films.dart';
import 'package:cinema_app/data/cities.dart';

class TicketFront extends StatefulWidget {
  final TicketData ticketData;
  const TicketFront({@required this.ticketData});

  @override
  State<StatefulWidget> createState() =>
      _TicketFrontState(ticketData: ticketData);
}

class _TicketFrontState extends State<TicketFront> {
  _TicketFrontState({@required this.ticketData});

  // Configuration
  final double height = 210.0;
  final borderColor = Colors.grey[850];
  final backgroundColor = Color(0xff0b0b0b);
  final mainTextColor = Colors.white;
  final secondaryTextColor = Colors.deepOrange[800];

  // Working variables
  final TicketData ticketData;
  final filmsData = FilmsData();
  final citiesData = CitiesData();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: this.height,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(6.0),
        color: backgroundColor,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 190,
              child: Image.asset(
                filmsData.getFilm(ticketData.idFilm).imagePath,
                scale: 1.5,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: mainTextColor,
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  backgroundColor,
                  backgroundColor.withOpacity(0.9),
                  backgroundColor.withOpacity(0.0)
                ],
                stops: [0.5, 0.7, 1.0],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildTitleCity(),
                _buildDate(),
                _buildPosition(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildTitleCity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 220,
          child: Text(
            filmsData.getFilm(ticketData.idFilm).title.toString().toUpperCase(),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 2,
              color: mainTextColor,
              fontFamily: 'Oswald',
            ),
          ),
        ),
        Text(
          citiesData.getCity(ticketData.idCity).name.toString(),
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 15,
            color: secondaryTextColor,
            fontFamily: 'OpenSans',
          ),
        ),
      ],
    );
  }

  _buildDate() {
    final ticketDate = ticketData.filmDateTime;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          DateFormat('dd / MM / yyyy').format(ticketDate),
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 15,
            color: mainTextColor,
          ),
        ),
        Text(
          ticketDate.hour.toString() + " : " + ticketDate.minute.toString(),
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 2,
            color: secondaryTextColor,
            fontFamily: 'Oswald',
          ),
        ),
      ],
    );
  }

  _buildPositionInfo() {
    final textStyle = TextStyle(
      color: mainTextColor
    );
    return Stack(
      children: <Widget>[
        Text(
          "Sala",
          style: textStyle,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Text(
            "Fila",
            style: textStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 120),
          child: Text(
            "Posto",
            style: textStyle,
          ),
        )
      ],
    );
  }

  _buildPosition() {
    final textStyle = TextStyle(
      fontSize: 18,
      fontFamily: 'Oswald',
      color: secondaryTextColor,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildPositionInfo(),
        Stack(
          children: <Widget>[
            Text(
              ticketData.room.toString(),
              style: textStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Text(
                ticketData.row.toString(),
                style: textStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120),
              child: Text(
                ticketData.seat.toString(),
                style: textStyle,
              ),
            )
          ],
        ),
      ],
    );
  }
}
