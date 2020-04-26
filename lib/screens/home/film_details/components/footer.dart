// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'package:cinema_app/data/films.dart';

// Next page
import 'package:cinema_app/transitions/slide_top_route.dart';
import 'package:cinema_app/screens/home/buy_ticket/buy_ticket.dart';

class FilmDetailsFooter extends StatelessWidget {
  final Film film;
  final double height;
  final double gradientHeight;
  final double bottomPadding;

  FilmDetailsFooter({
    this.film,
    this.height,
    this.gradientHeight,
    this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Gradiente
        Container(
          width: double.infinity,
          height: this.gradientHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Theme.of(context).backgroundColor,
                Theme.of(context).backgroundColor.withOpacity(0.0),
              ],
              stops: [0.2, 1.0],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: this.bottomPadding),
          child: Container(
            width: 200,
            height: 50,
            child: FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.deepOrange[900],
              highlightColor: Colors.white24,
              splashColor: Colors.white38,
              textColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 22,
                  ),
                  Text(
                    "Acquista",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 40,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  SlideTopRoute(
                    page: BuyTicket(film: this.film),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
