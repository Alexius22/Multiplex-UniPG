// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'dart:math';

// DB
import 'package:cinema_app/services/auth.dart';
import 'package:cinema_app/services/tickets.dart';
import 'package:cinema_app/services/schedules.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Import data structures
import 'package:cinema_app/models/schedule.dart';
import 'package:cinema_app/models/ticket.dart';
import 'package:cinema_app/models/ticket_snack.dart';

// Widget
import 'package:cinema_app/widgets/appbars/go_back_appbar.dart';
import 'package:cinema_app/widgets/buttons/custom_button.dart';
import 'package:toast/toast.dart';

// Utils
import 'package:cinema_app/utils/format.dart';

class Checkout extends StatelessWidget {
  final Schedule schedule;
  final List<Point<int>> seats;
  final List<TicketSnack> snacks;
  final double totalCost;

  Checkout({
    this.schedule,
    this.seats,
    this.snacks,
    this.totalCost,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle _primaryTextStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: MediaQuery.of(context).size.height / 45,
    );

    final TextStyle _secondaryTextStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: MediaQuery.of(context).size.height / 36,
      fontWeight: FontWeight.bold,
      color: Colors.deepOrange[800],
    );

    return Scaffold(
      appBar: GoBackAppBar("Riepilogo ordine").build(context),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 11,
                  left: MediaQuery.of(context).size.width / 26,
                  right: MediaQuery.of(context).size.width / 26),
              child: Divider(
                thickness: 2,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 52),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Totale:",
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: MediaQuery.of(context).size.height / 45,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 40),
                  Text(
                    "€ $totalCost",
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height / 31,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 26),
                  CustomButton(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 16,
                    text: "Acquista",
                    icon: Icons.shopping_cart,
                    onTap: () => _buyTicket(context),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 3 / 4 * MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 40),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          schedule.film.imageURL,
                          width: MediaQuery.of(context).size.width / 2.8,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 26),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              schedule.film.title,
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize:
                                    MediaQuery.of(context).size.height / 30,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 52),
                            _buildInfo(
                              context,
                              'Data:',
                              formatDate(schedule.dateTime, extended: true),
                              _primaryTextStyle,
                              _secondaryTextStyle,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 52),
                            _buildInfo(
                              context,
                              'Orario:',
                              formatTime(schedule.dateTime),
                              _primaryTextStyle,
                              _secondaryTextStyle,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 52),
                            _buildInfo(
                              context,
                              'Tipologia:',
                              schedule.shotTypology,
                              _primaryTextStyle,
                              _secondaryTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _buildInfo(
                      context,
                      'Posti:',
                      seats
                          .map((Point<int> p) => formatSeat(p.x, p.y))
                          .toList()
                          .join(', '),
                      _primaryTextStyle,
                      _secondaryTextStyle,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 200),
                        child: Text("Snacks:", style: _primaryTextStyle),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 26),
                      snacks.length > 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: snacks
                                  .map(
                                    (TicketSnack s) => Text(
                                      s.toString(),
                                      style: _secondaryTextStyle,
                                    ),
                                  )
                                  .toList(),
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width / 180),
                              child: Opacity(
                                opacity: 0.8,
                                child: Text(
                                  "Nessuno...",
                                  style: _primaryTextStyle.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(context, String title, String content,
      TextStyle primaryTextStyle, TextStyle secondaryTextStyle) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: primaryTextStyle,
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 40),
          Expanded(
            child: Text(
              content,
              style: secondaryTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  void _buyTicket(context) async {
    // Prepare tickets
    final _user = await Auth().getCurrentUser();
    List<Map<String, dynamic>> _ticketsBought = [];

    for (Point<int> seat in seats)
      _ticketsBought.add({
        'schedule':
            Firestore.instance.collection('schedules').document(schedule.id),
        'row': seat.x,
        'seat': seat.y,
        'snacks': Map<String, dynamic>(),
        'user': _user.uid,
      });

    // Add food just to the first ticket
    _ticketsBought[0]['snacks'] = Map<String, Map<String, int>>.fromIterable(
      snacks,
      key: (s) => s.name,
      value: (s) => {s.size: s.quantity},
    );

    // Data are prepared: let's contact the server to buy the tickets
    String _reportMSG =
        "L'operazione è stata\ncompletata con SUCCESSO!\n\nControlla la sezione dei biglietti!";

    for (Map<String, dynamic> ticket in _ticketsBought)
      if (await FirestoreTickets().buyTicket(ticket) == false)
        _reportMSG =
            "Si è verificato un errore.\n\nControlla la tua connessione e riprova...";

    FirestoreSchedules().updateSeatsOccupied(schedule, seats);

    // Go back and show report message
    Navigator.popUntil(
      context,
      (Route<dynamic> route) => route.isFirst,
    );

    Toast.show(
      _reportMSG,
      context,
      duration: 6,
      gravity: Toast.CENTER,
      backgroundColor: Colors.grey[800].withOpacity(0.9),
    );
  }
}
