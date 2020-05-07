// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'dart:math';

// Models
import 'package:cinema_app/models/film.dart';
import 'package:cinema_app/models/schedule.dart';
import 'package:cinema_app/models/ticket_snack.dart';

// Components
import 'components/seat_checkbox.dart';
import 'components/snack_selector.dart';

// General purpose widgets
import 'package:cinema_app/widgets/appbars/go_back_appbar.dart';
import 'package:cinema_app/widgets/buttons/custom_button.dart';

// Utils
import 'package:cinema_app/utils/format.dart';
import 'package:cinema_app/utils/calendar.dart';

// Next page
import 'package:cinema_app/transitions/slide_left_route.dart';
import 'components/checkout.dart';

class BuyTicket extends StatefulWidget {
  final Film film;
  final List<Schedule> schedules;
  final Set<String> shotTypologies;

  BuyTicket({this.film, this.schedules})
      : shotTypologies = schedules.map((Schedule s) => s.shotTypology).toSet();

  @override
  _State createState() => new _State();
}

class _State extends State<BuyTicket> with SingleTickerProviderStateMixin {
  // User choices
  // Note: if hour still have to be picked,
  // _dateTimePicked's hour will be set to 00:01, to avoid conflicts
  Schedule _schedulePicked;
  String _shotTyplogyPicked;
  DateTime _dateTimePicked;
  List<Point> _seatsPicked = [];
  List<TicketSnack> _snacksPicked = [];

  // Working variables
  // Note: _dateTimes will be updated
  // every time _shotTyplogyPicked will change
  List<DateTime> _dateTimes;
  List<String> _hours;

  @override
  Widget build(BuildContext context) {
    print(widget.film);
    print(widget.schedules);
    return Scaffold();
  }
}
