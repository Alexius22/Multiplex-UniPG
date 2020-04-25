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
        color: Theme.of(context).backgroundColor,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width / 2.15,
              child: Image.asset(
                filmsData.getFilm(ticketData.idFilm).imagePath,
                scale: 1.5,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Theme.of(context).backgroundColor,
                  Theme.of(context).backgroundColor.withOpacity(0.9),
                  Theme.of(context).backgroundColor.withOpacity(0.0)
                ],
                stops: [0.5, 0.7, 1.0],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 26,
              vertical: MediaQuery.of(context).size.height / 67,
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
          width: MediaQuery.of(context).size.width / 1.9,
          child: Text(
            filmsData.getFilm(ticketData.idFilm).title.toString().toUpperCase(),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 40,
              letterSpacing: 2,
              fontFamily: 'Oswald',
            ),
          ),
        ),
        Text(
          citiesData.getCity(ticketData.idCity).name.toString(),
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 52,
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
            fontSize: MediaQuery.of(context).size.height / 52,
          ),
        ),
        Text(
          DateFormat('HH : mm').format(ticketDate),
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 45,
            letterSpacing: 2,
            color: secondaryTextColor,
            fontFamily: 'Oswald',
          ),
        ),
      ],
    );
  }

  _buildPositionInfo() {
    return Stack(
      children: <Widget>[
        Text(
          "Sala",
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 7),
          child: Text(
            "Fila",
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 3.4),
          child: Text(
            "Posto",
          ),
        )
      ],
    );
  }

  _buildPosition() {
    final textStyle = TextStyle(
      fontSize: MediaQuery.of(context).size.height / 45,
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
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 7),
              child: Text(
                ticketData.row,
                style: textStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 3.4),
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
