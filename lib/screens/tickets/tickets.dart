// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// DB
import 'package:cinema_app/models/ticket.dart';
import 'package:cinema_app/services/tickets.dart';
import 'package:cinema_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Import widgets
import 'package:cinema_app/widgets/loading/loading_screen.dart';
import 'package:cinema_app/widgets/buttons/custom_button.dart';
import 'package:flip_card/flip_card.dart';
import 'components/ticket_front.dart';
import 'components/ticket_back.dart';

class TicketScreen extends StatelessWidget {
  // Configuration
  final padding = 25.0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: Auth().getCurrentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return LoadingScreen();

        if (snapshot.data == null)
          return Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                "Devi autenticarti prima di\npoter vedere i tuoi biglietti.",
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );

        return FutureBuilder<List<Ticket>>(
          future: FirestoreTickets().fetchTickets(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Ticket>> snapshot) {
            if (!snapshot.hasData) return LoadingScreen();
            final _tickets = snapshot.data;
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                appBar: TabBar(
                  tabs: [
                    Tab(
                      text: "Da vedere",
                      icon: Icon(Icons.watch_later),
                    ),
                    Tab(
                      text: "Archivio",
                      icon: Icon(Icons.archive),
                    ),
                  ],
                ),
                body: TabBarView(
                  children: [
                    ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(padding),
                      itemCount: _tickets.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildTicket(
                          ticket: _tickets[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: padding),
                    ),
                    ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(padding),
                      itemCount: _tickets.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildTicket(
                          ticket: _tickets[index],
                          onlyFront: true,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: padding),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  _buildTicket({Ticket ticket, bool onlyFront: false}) {
    return onlyFront
        ? TicketFront(ticket: ticket)
        : FlipCard(
            direction: FlipDirection.HORIZONTAL,
            front: TicketFront(ticket: ticket),
            back: TicketBack(ticket: ticket),
          );
  }
}
