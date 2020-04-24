// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

import 'package:cinema_app/screens/home/home.dart';
import 'package:cinema_app/transitions/slide_top_route.dart';

class Checkout extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<Checkout> {
  void _onBuyPressed() {
    Navigator.push(context, SlideTopRoute(page: HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    _buildBackButton(context),
                    _buildHead(),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 5,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[
                        _buildCheckout("Film: ", "Avengers: Endgame"),
                        _buildCheckout("Tipologia: ", "2D"),
                        _buildCheckout("Giorno: ", "22/04/2020"),
                        _buildCheckout("Orario: ", "20:45"),
                        _buildCheckout(
                            "Posti selezionati: ", "A1, B6, H9, C3, G1"),
                        _buildCheckout("Snack scelti: ",
                            "Acqua: 1\nSmarties: 3\nPatatine (M): 1\nPopCorn (L): 4\nCoca-Cola (M): 2\nMars: 1\nMenù Nachos (S): 3"),
                        _buildCheckout("Totale: ", "€ 57.00"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _buyButton(),
          ],
        ));
  }

  Widget _buildBackButton(context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 40,
            top: MediaQuery.of(context).size.width / 40),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: MediaQuery.of(context).size.height / 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildHead() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 60),
        child: Center(
          child: Text(
            "Riepilogo ordine",
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckout(title, choice) {
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
                    fontSize: 18,
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
                    fontSize: 20,
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

  Widget _buyButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height / 50),
        Center(
          child: Container(
            height: 50,
            width: 200,
            child: MaterialButton(
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
                      fontSize: 20,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              onPressed: _onBuyPressed,
            ),
          ),
        ),
      ],
    );
  }
}
