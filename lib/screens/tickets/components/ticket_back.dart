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
  final mainTextColor = Colors.white;
  final main2TextColor = Colors.deepOrange[800];

  // Timer configuration
  Duration countDownCurrent = Duration(minutes: 50, seconds: 30);
  Duration countDownCurrent2 = Duration(minutes: 1, seconds: 30);

  // Working variables
  Timer timer;
  Timer timer2;
  String countDownText;
  String countDownText2;
  String barCode;

  @override
  void initState() {
    // Prepare bar code
    barCode = ticketData.idFilm.toString() +
        ticketData.idCity.toString() +
        ticketData.row.toString() +
        ticketData.seat.toString();

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
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // Consumables
          Container(
            height: MediaQuery.of(context).size.height / 12.5,
            child: _buildFoodSection(),
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
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 4),
            child: BarCodeImage(
              params: Code39BarCodeParams(
                barCode,
                lineWidth: 3.0,
                barHeight: MediaQuery.of(context).size.height / 20,
                withText: false,
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

  Widget _buildFoodSection() {
    if (ticketData.snacks.length > 0)
      return Center(
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 26,
              right: MediaQuery.of(context).size.width / 26),
          itemCount: ticketData.snacks.length,
          itemBuilder: (BuildContext context, int i) {
            return _buildFoodReminder(
              label: ticketData.snacks[i].label,
              dim: ticketData.snacks[i].dim,
              n: ticketData.snacks[i].quantity,
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(width: MediaQuery.of(context).size.width / 26),
        ),
      );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Opacity(
          opacity: 0.6,
          child: Text(
            "Non hai incluso nessuno snack...",
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Text(
          "Potrai comunque acquistarne al nostro bar!",
        ),
      ],
    );
  }

  Widget _buildFoodReminder({label, dim, n}) {
    return Column(
      children: <Widget>[
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: MediaQuery.of(context).size.height / 56.5,
          ),
        ),
        Opacity(
          opacity: 0.6,
          child: Text(
            dim,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "OpenSans",
              fontSize: MediaQuery.of(context).size.height / 67,
              letterSpacing: 1,
            ),
          ),
        ),
        Text(
          "$n",
          style: TextStyle(
            fontFamily: "Oswald",
            fontSize: MediaQuery.of(context).size.height / 40,
            color: main2TextColor,
          ),
        ),
      ],
    );
  }

  _buildTimerFilmStart() {
    return Column(
      children: <Widget>[
        Opacity(
          opacity: 0.6,
          child: Text(
            "Inizio Film",
            style: TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.height / 50,
              letterSpacing: 2,
            ),
          ),
        ),
        Text(
          "$countDownText",
          style: TextStyle(
            fontFamily: "Oswald",
            fontSize: MediaQuery.of(context).size.height / 32,
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
        Opacity(
          opacity: 0.6,
          child: Text(
            "Intervallo",
            style: TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.height / 50,
              letterSpacing: 2,
            ),
          ),
        ),
        Text(
          "$countDownText2",
          style: TextStyle(
            fontFamily: "Oswald",
            fontSize: MediaQuery.of(context).size.height / 32,
            letterSpacing: 3,
            color: main2TextColor,
          ),
        ),
      ],
    );
  }
}
