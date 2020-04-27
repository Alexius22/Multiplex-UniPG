// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// Widget
import 'package:cinema_app/widgets/appbars/go_back_appbar.dart';
import 'package:cinema_app/widgets/buttons/button_icon.dart';

class Checkout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBar("Riepilogo ordine").build(context),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / 5,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      _buildCheckout(context, "Film: ", "Avengers: Endgame"),
                      _buildCheckout(context, "Tipologia: ", "2D"),
                      _buildCheckout(context, "Giorno: ", "22/04/2020"),
                      _buildCheckout(context, "Orario: ", "20:45"),
                      _buildCheckout(
                          context, "Posti selezionati: ", "A1, B6, H9, C3, G1"),
                      _buildCheckout(context, "Snack scelti: ",
                          "Acqua: 1\nSmarties: 3\nPatatine (M): 1\nPopCorn (L): 4\nCoca-Cola (M): 2\nMars: 1\nMenù Nachos (S): 3"),
                      _buildCheckout(context, "Totale: ", "€ 57.00"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _buyButton(context),
        ],
      ),
    );
  }

  Widget _buildCheckout(context, title, choice) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: MediaQuery.of(context).size.height / 45,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  choice,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height / 40,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buyButton(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height / 50),
        Center(
          child: ButtonWithIcon(
            width: 160,
            text: "Acquista",
            icon: Icons.shopping_cart,
            onTap: () {
              Navigator.popUntil(
                context,
                (Route<dynamic> route) => route.isFirst,
              );
            },
          ),
        ),
      ],
    );
  }
}
