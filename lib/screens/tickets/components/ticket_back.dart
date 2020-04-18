// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_flutter/barcode_flutter.dart';

import 'package:cinema_app/data/tickets.dart';

class TicketBack extends StatefulWidget {
  final TicketData ticketData;
  const TicketBack({@required this.ticketData});

  @override
  State<StatefulWidget> createState() =>
      _TicketBackState(ticketData: ticketData);
}

class _TicketBackState extends State<TicketBack> {
  final TicketData ticketData;
  _TicketBackState({@required this.ticketData});

  // Configuration
  final double height = 210.0;
  final borderColor = Colors.grey[850];
  final backgroundColor = Color(0xff0b0b0b);
  final mainTextColor = Colors.white;
  final main2TextColor = Colors.deepOrange[800];
  final secondaryTextColor = Colors.grey[500];

  // Timer configuration
  Duration countDownCurrent = Duration(minutes: 1, seconds: 30);
  Duration countDownCurrent2 = Duration(minutes: 50, seconds: 30);

  // Working variables
  Timer timer;
  Timer timer2;
  String countDownText;
  String countDownText2;
  String barCode;
  List<Widget> _consumables = [];

  @override
  void initState() {
    // Prepare bar code
    barCode = ticketData.idFilm.toString() +
        ticketData.idCity.toString() +
        ticketData.row.toString() +
        ticketData.seat.toString();

    // Prepare food
    for (var consumable in ticketData.consumables) {
      _consumables.add(_buildFoodReminder(consumable.label, consumable.n));
    }

    // Prepare timer
    String _durationToString(Duration duration) {
      String twoDigits(int n) {
        if (n >= 10) return "$n";
        return "0$n";
      }

      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "$twoDigitMinutes:$twoDigitSeconds";
    }

    countDownText = _durationToString(countDownCurrent);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countDownCurrent -= Duration(seconds: 1);
        if (countDownCurrent != Duration(seconds: 0)) {
          countDownText = _durationToString(countDownCurrent);
        } else {
          timer.cancel();
          countDownText = "00:00";
        }
      });
    });

    countDownText2 = _durationToString(countDownCurrent2);
    timer2 = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countDownCurrent2 -= Duration(seconds: 1);
        if (countDownCurrent2 != Duration(seconds: 0)) {
          countDownText2 = _durationToString(countDownCurrent2);
        } else {
          timer2.cancel();
          countDownText2 = "00:00";
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    timer2.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create interface
    return Container(
      width: double.infinity,
      height: this.height,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(6.0),
        color: backgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // Consumables
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _consumables,
            ),
          ),
          Divider(height: 0, thickness: 1.2, color: borderColor),
          // Timers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildTimerFilmStart(),
              _buildTimerInterval(),
            ],
          ),
          Divider(height: 0, thickness: 1.2, color: borderColor),
          // BarCode
          Center(
            child: BarCodeImage(
              params: Code39BarCodeParams(
                barCode,
                lineWidth: 3.0,
                barHeight: 50.0,
                withText: true,
              ),
              onError: (error) {
                // Error handler
                print('error = $error');
              },
            ),
          )
        ],
      ),
    );
  }

  _buildFoodReminder(text, n) {
    return Column(
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            fontFamily: "OpenSans",
            color: secondaryTextColor,
          ),
        ),
        Text(
          "$n",
          style: TextStyle(
            fontFamily: "Oswald",
            fontSize: 20,
            color: mainTextColor,
          ),
        ),
      ],
    );
  }

  _buildTimerFilmStart() {
    return Column(
      children: <Widget>[
        Text(
          "Inizio Film",
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 16,
            letterSpacing: 2,
            color: secondaryTextColor,
          ),
        ),
        Text(
          "$countDownText",
          style: TextStyle(
            fontFamily: "Oswald",
            fontSize: 30,
            letterSpacing: 3,
            color: main2TextColor,
          ),
        ),
      ],
    );
  }

  _buildTimerInterval() {
    return Column(
      children: <Widget>[
        Text(
          "Intervallo",
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 16,
            letterSpacing: 2,
            color: secondaryTextColor,
          ),
        ),
        Text(
          "$countDownText2",
          style: TextStyle(
            fontFamily: "Oswald",
            fontSize: 30,
            letterSpacing: 3,
            color: main2TextColor,
          ),
        ),
      ],
    );
  }
}
