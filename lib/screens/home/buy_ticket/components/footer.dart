// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'dart:math';

// Import models
import 'package:cinema_app/models/general.dart';
import 'package:cinema_app/models/schedule.dart';
import 'package:cinema_app/models/snack.dart';
import 'package:cinema_app/models/ticket_snack.dart';

// Import widgets
import 'package:cinema_app/widgets/buttons/custom_button.dart';

// Next page
import 'package:cinema_app/transitions/slide_left_route.dart';
import '../checkout.dart';

class BuyTicketFooter extends StatelessWidget {
  final Schedule schedule;
  final GeneralInfo generalInfo;
  final List<Snack> snackTypologies;
  final List<Point<int>> seatsPicked;
  final List<TicketSnack> snacksPicked;

  BuyTicketFooter({
    this.schedule,
    this.generalInfo,
    this.snackTypologies,
    this.seatsPicked,
    this.snacksPicked,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate total cost of the current configuration
    double _totalCost =
        generalInfo.ticketPrices[schedule.shotTypology]['Intero'].toDouble() *
            seatsPicked.length;

    // Calculate snacks cost
    for (TicketSnack snack in snacksPicked)
      _totalCost += snackTypologies
              .where((Snack s) => s.name == snack.name)
              .toList()[0]
              .priceList[snack.size] *
          snack.quantity;

    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(MediaQuery.of(context).size.height / 28.5),
          child: Row(
            children: <Widget>[
              Text(
                "Totale:",
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: MediaQuery.of(context).size.height / 45,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 20),
              Text(
                "€ $_totalCost",
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height / 31,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.all(MediaQuery.of(context).size.height / 40),
          child: CustomButton(
            width: MediaQuery.of(context).size.width / 2.55,
            text: "Riepilogo",
            icon: Icons.arrow_forward_ios,
            onTap: this.seatsPicked.length == 0
                ? null
                : () {
                    Navigator.push(
                      context,
                      SlideLeftRoute(
                        page: Checkout(
                          schedule: schedule,
                          seats: seatsPicked,
                          snacks: snacksPicked,
                          totalCost: _totalCost,
                        ),
                      ),
                    );
                  },
          ),
        ),
      ],
    );
  }
}
