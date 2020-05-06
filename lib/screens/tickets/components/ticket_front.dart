// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cinema_app/models/ticket.dart';

class TicketFront extends StatelessWidget {
  final Ticket ticket;
  TicketFront({@required this.ticket});

  // Configuration
  final double height = 210.0;
  final borderColor = Colors.grey[850];
  final secondaryTextColor = Colors.deepOrange[800];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: this.height,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Stack(
        children: <Widget>[
          // Film image
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width / 2.15,
              child: Image.network(
                ticket.schedule.film.imageURL,
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
                  Theme.of(context).backgroundColor.withOpacity(0.0)
                ],
                stops: [0.5, 0.9],
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
                _buildTitleCity(context),
                _buildDate(context),
                _buildPosition(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildTitleCity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 1.9,
          child: Text(
            ticket.schedule.film.title.toUpperCase(),
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 40,
              letterSpacing: 2,
              fontFamily: 'Oswald',
            ),
          ),
        ),
        Text(
          ticket.schedule.room.cinema.city,
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

  _buildDate(BuildContext context) {
    // Save datetime of the schedule for double use
    final ticketDateTime = ticket.schedule.dateTime;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          DateFormat('dd / MM / yyyy').format(ticketDateTime),
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 52,
          ),
        ),
        Text(
          DateFormat('HH : mm').format(ticketDateTime),
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

  _buildPositionInfo(BuildContext context) {
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

  _buildPosition(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: MediaQuery.of(context).size.height / 45,
      fontFamily: 'Oswald',
      color: secondaryTextColor,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildPositionInfo(context),
        Stack(
          children: <Widget>[
            Text(
              ticket.schedule.room.name.toString(),
              style: textStyle,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 7),
              child: Text(
                ticket.row.toString(),
                style: textStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 3.4),
              child: Text(
                ticket.seat.toString(),
                style: textStyle,
              ),
            )
          ],
        ),
      ],
    );
  }
}
