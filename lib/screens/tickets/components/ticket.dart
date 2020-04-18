// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

import 'package:cinema_app/data/tickets.dart';
import './ticket_front.dart';
import './ticket_back.dart';

class Ticket extends StatefulWidget {
  final TicketData ticketData;
  const Ticket({@required this.ticketData});

  @override
  State<StatefulWidget> createState() => _TicketState(ticketData: ticketData);
}

class _TicketState extends State<Ticket> {
  final TicketData ticketData;
  _TicketState({@required this.ticketData});

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      front: TicketFront(ticketData: ticketData),
      back: TicketBack(ticketData: ticketData),
    );
  }
}
