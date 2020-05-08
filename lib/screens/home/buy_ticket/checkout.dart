// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:cinema_app/utils/format.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// Import data structures
import 'package:cinema_app/models/schedule.dart';
import 'package:cinema_app/models/ticket_snack.dart';

// Widget
import 'package:cinema_app/widgets/appbars/go_back_appbar.dart';
import 'package:cinema_app/widgets/buttons/custom_button.dart';

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
    return Scaffold(
      appBar: GoBackAppBar("Riepilogo ordine").build(context),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / 5,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      _buildCheckout(context, "Film: ", schedule.film.title),
                      _buildCheckout(
                          context, "Tipologia: ", schedule.shotTypology),
                      _buildCheckout(context, "Giorno: ",
                          formatDate(schedule.dateTime, '')),
                      _buildCheckout(
                          context, "Orario: ", formatTime(schedule.dateTime)),
                      _buildCheckout(
                          context, "Posti selezionati: ", seats.join(', ')),
                      _buildCheckout(
                        context,
                        "Snack scelti: ",
                        snacks.join(', '),
                      ),
                      _buildCheckout(context, "Totale: ", "€ $totalCost"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _buyButton(context),
        ],
      ),
    );
  }

  Widget _buildCheckout(context, title, choice) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: MediaQuery.of(context).size.height / 45,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  choice,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height / 40,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buyButton(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height / 50),
        Center(
          child: CustomButton(
            width: 160,
            text: "Acquista",
            icon: Icons.shopping_cart,
            onTap: () {
              Navigator.popUntil(
                context,
                (Route<dynamic> route) => route.isFirst,
              );
            },
          ),
        ),
      ],
    );
  }
}
