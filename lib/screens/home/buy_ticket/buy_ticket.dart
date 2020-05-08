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
  final Schedule schedule;

  BuyTicket({this.film, this.schedule});

  @override
  _State createState() => new _State();
}

class _State extends State<BuyTicket> with SingleTickerProviderStateMixin {
  // User choices
  List<Point<int>> _seatsPicked = [];
  List<TicketSnack> _snacksPicked = [];

  @override
  Widget build(BuildContext context) {
    print(widget.film.title);
    print(widget.schedule.dateTime);
    print(widget.schedule.shotTypology);
    return Scaffold();
  }
}
