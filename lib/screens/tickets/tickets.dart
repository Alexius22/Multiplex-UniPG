// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

import 'package:cinema_app/data/tickets.dart';
import './components/ticket.dart';

class TicketScreen extends StatefulWidget {
  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  // Configuration
  final backgroundColor = Colors.black;
  final padding = 25.0;

  // Read random tickets
  final List<TicketData> _tickets = TicketsData().getAll;

  // Working variables
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        child: ListView.separated(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(padding),
          itemCount: _tickets.length,
          itemBuilder: (BuildContext context, int index) {
            return Ticket(
              ticketData: _tickets.elementAt(index),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: padding),
        ),
      ),
    );
  }
}
