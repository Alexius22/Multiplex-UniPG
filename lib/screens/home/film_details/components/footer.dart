// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';
import 'package:cinema_app/data/films.dart';

// Widget
import 'package:cinema_app/widgets/buttons/button_icon.dart';

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
          child: ButtonWithIcon(
            width: 150,
            height: this.height,
            text: "Prenota",
            icon: Icons.arrow_forward_ios,
            onTap: () {
              Navigator.push(
                context,
                SlideTopRoute(
                  page: BuyTicket(film: this.film),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
