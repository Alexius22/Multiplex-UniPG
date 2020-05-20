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
                  fontSize: 22,
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

            // Get all tickets sorted by datetime
            var _tickets = List<Ticket>.from(snapshot.data);
            _tickets.sort((t1, t2) =>
                t1.schedule.dateTime.compareTo(t2.schedule.dateTime));

            // Separate tickets: "to watch" and "archive"
            var _tickets_to_watch = [];
            var _tickets_archive = [];
            final DateTime _now =
                DateTime.now().add(Duration(hours: 3));

            _tickets.forEach((Ticket t) {
              if (t.schedule.dateTime.isAfter(_now))
                _tickets_to_watch.add(t);
              else
                _tickets_archive.add(t);
            });

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
                    _tickets_to_watch.length > 0
                        ? ListView.separated(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.all(padding),
                            itemCount: _tickets_to_watch.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _buildTicket(
                                ticket: _tickets_to_watch[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    SizedBox(height: padding),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Opacity(
                                opacity: 0.6,
                                child: Text(
                                  "Non hai film da vedere...",
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                "Acquista dei biglietti!",
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 22,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                    _tickets_archive.length > 0
                        ? ListView.separated(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.all(padding),
                            itemCount: _tickets_archive.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _buildTicket(
                                ticket: _tickets_archive[index],
                                onlyFront: true,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    SizedBox(height: padding),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Opacity(
                                opacity: 0.6,
                                child: Text(
                                  "Non hai visto ancora nessun film...",
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                "Troverai qui quelli visti!",
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 22,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
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
