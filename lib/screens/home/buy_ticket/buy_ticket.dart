// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'dart:math';

// Models
import 'package:cinema_app/models/general.dart';
import 'package:cinema_app/models/film.dart';
import 'package:cinema_app/models/schedule.dart';
import 'package:cinema_app/models/snack.dart';
import 'package:cinema_app/models/ticket_snack.dart';

// DB
import 'package:cinema_app/services/snacks.dart';
import 'package:cinema_app/services/general.dart';

// Components
import 'components/footer.dart';
import 'components/seat_checkbox.dart';
import 'components/snack_selector.dart';

// General purpose widgets && utils
import 'package:cinema_app/widgets/appbars/go_back_appbar.dart';
import 'package:cinema_app/widgets/loading/loading_screen.dart';
import 'package:cinema_app/utils/format.dart';

class BuyTicket extends StatefulWidget {
  final Film film;
  final Schedule schedule;

  final FirestoreSnacks snacksDB = FirestoreSnacks();
  final FirestoreGeneral generalRef = FirestoreGeneral();

  BuyTicket({this.film, this.schedule});

  @override
  _State createState() => new _State();
}

class _State extends State<BuyTicket> with SingleTickerProviderStateMixin {
  // User choices
  List<Point<int>> _seatsPicked = [];
  Map<String, TicketSnack> _snacksPicked = {};

  // Working variables
  List<Widget> _snackSelectors = [];

  @override
  Widget build(BuildContext context) {
    // Config
    final TextStyle _secondaryStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
      color: Colors.deepOrange,
      fontSize: MediaQuery.of(context).size.height / 40,
    );

    return FutureBuilder<List<dynamic>>(
      // TODO: Could it be usefull to fetch update again of the schedule?
      future: Future.wait(
          [widget.generalRef.fetchUpdates(), widget.snacksDB.fetchSnacks()]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        // Wait for data
        if (!snapshot.hasData) return LoadingScreen();

        // Extract datas
        final GeneralInfo _general = snapshot.data[0];
        final List<Snack> _snacks = snapshot.data[1];

        // Build selectors individually
        if (_snackSelectors.length == 0)
          for (final Snack _snack in _snacks) {
            // Create selector
            _snackSelectors.add(
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 14,
                ),
                child: SnackSelector(
                  snackTypology: _snack,
                  onSnackChanged: (TicketSnack ticketSnack) {
                    setState(() {
                      if (ticketSnack.quantity > 0)
                        _snacksPicked[ticketSnack.name + ticketSnack.size] =
                            ticketSnack;
                      else
                        _snacksPicked
                            .remove(ticketSnack.name + ticketSnack.size);
                    });
                  },
                ),
              ),
            );
          }

        return Scaffold(
          appBar: GoBackAppBar("Il tuo ordine").build(context),
          body: Stack(
            children: <Widget>[
              // Total amount, buy button, discounts
              BuyTicketFooter(
                schedule: widget.schedule,
                generalInfo: _general,
                snackTypologies: _snacks,
                seatsPicked: this._seatsPicked,
                snacksPicked: this._snacksPicked,
              ),
              // Seats selection, snacks selection
              Container(
                height: 3 / 4 * MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 15),
                      _buildScreen(
                        height: MediaQuery.of(context).size.height / 15,
                      ),
                      SizedBox(height: 5),
                      _buildSeats(
                        schedule: widget.schedule,
                        height: MediaQuery.of(context).size.height / 2.2,
                      ),
                      SizedBox(height: 10),
                      _buildLegend(),
                      SizedBox(height: 15),
                      _buildSeatsSummary(_secondaryStyle),
                      SizedBox(height: 20),
                      _buildOptionalSnacks(
                        snackSelectors: _snackSelectors,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScreen({double height}) {
    return CustomPaint(
      size: Size(
        MediaQuery.of(context).size.width / 1.2,
        height,
      ),
      painter: ScreenPainter(
        angleLimiter: 0.2,
        strokeWidth: 1.3,
        strokeColor: Theme.of(context).textTheme.title.color,
        blurValue: 6.0,
        fillColor: Colors.deepOrange.withOpacity(0.5),
      ),
    );
  }

  Widget _buildSeats({Schedule schedule, double height}) {
    List<Row> checkBoxRows = [];
    final bool _isDarkThemeEnabled =
        Theme.of(context).backgroundColor == Colors.black;

    for (int i = schedule.room.rows - 1; i >= 0; i--) {
      List<SeatCheckBox> checkBoxRow = [];
      for (int j = 0; j < schedule.room.columns; j++) {
        final SeatCheckBox _seat = SeatCheckBox(
          width: MediaQuery.of(context).size.width / 12,
          backgroundColor: _isDarkThemeEnabled ? Colors.black : Colors.white,
          backgroundColorChecked: Colors.deepOrange[900],
          borderColor: _isDarkThemeEnabled ? Colors.grey : Colors.grey[600],
          borderColorChecked: Colors.deepOrange,
          highlightColor: _isDarkThemeEnabled
              ? Colors.white24
              : Colors.deepOrange[500].withOpacity(0.5),
          splashColor:
              _isDarkThemeEnabled ? Colors.white38 : Colors.deepOrange[900],
          checked: false,
          disabled: schedule.seatsOccupied
                  .where((Point<int> p) => p.y == i && p.x == j)
                  .length >
              0,
          onCheckChange: (status) {
            setState(() {
              if (status)
                _seatsPicked.add(Point<int>(j, i));
              else
                _seatsPicked.remove(Point<int>(j, i));
            });
          },
        );
        checkBoxRow.add(_seat);
      }
      checkBoxRows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: checkBoxRow,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 10,
        right: MediaQuery.of(context).size.width / 10,
      ),
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: checkBoxRows,
      ),
    );
  }

  Widget _buildLegend() {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 14,
          right: MediaQuery.of(context).size.width / 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildLegendLabel(
              Icons.radio_button_unchecked, Colors.grey, "Disponibile"),
          _buildLegendLabel(
              Icons.brightness_1, Colors.deepOrange[800], "Selezionato"),
          _buildLegendLabel(Icons.brightness_1, Colors.grey, "Riservato"),
        ],
      ),
    );
  }

  Widget _buildLegendLabel(icon, color, text) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: color,
          size: MediaQuery.of(context).size.height / 40,
        ),
        SizedBox(width: 3),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.height / 52,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSeatsSummary(_secondaryStyle) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width / 10,
        right: MediaQuery.of(context).size.width / 10,
      ),
      child: Row(
        children: <Widget>[
          Text(
            "Posti:",
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: MediaQuery.of(context).size.height / 45,
              letterSpacing: 1,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 40),
          // Animation WIP, to be fixed
          Container(
            width: MediaQuery.of(context).size.width / 1.7,
            alignment: Alignment.centerLeft,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 0),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(child: child, opacity: animation);
              },
              child: Text(
                _seatsPicked.isEmpty == true
                    ? "..."
                    : "${_seatsPicked.map((Point<int> p) => formatSeat(p.x, p.y)).toList().join(', ')}",
                style: _secondaryStyle,
                key: ValueKey<int>(_seatsPicked.length),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionalSnacks({List<Widget> snackSelectors}) {
    return ExpansionTile(
      title: Text(
        "Vuoi includere uno snack?",
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height / 40,
        ),
      ),
      children: snackSelectors,
    );
  }
}

class ScreenPainter extends CustomPainter {
  final double angleLimiter;
  final double strokeWidth;
  final Color strokeColor;
  final double blurValue;
  final Color fillColor;

  ScreenPainter({
    this.angleLimiter,
    this.strokeWidth,
    this.strokeColor,
    this.blurValue,
    this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height * 2),
      pi + angleLimiter,
      pi - angleLimiter * 2,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..isAntiAlias = true
        ..color = strokeColor,
    );
    canvas.drawArc(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height * 2),
      pi + angleLimiter,
      pi - angleLimiter * 2,
      false,
      Paint()
        ..style = PaintingStyle.fill
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurValue)
        ..isAntiAlias = true
        ..color = fillColor,
    );
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
