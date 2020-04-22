// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:cinema_app/screens/profile/add_card.dart';
import 'package:flutter/material.dart';

import 'package:cinema_app/transitions/slide_top_route.dart';

class Cards extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<Cards> {
  void _onAddPressed() {
    Navigator.push(context, SlideTopRoute(page: AddCard()));
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
              _infoBox(),
              Container(
                height: MediaQuery.of(context).size.height - 225,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      _card("Postepay", "termina con 1234", true),
                      _card("MasterCard", "termina con 1234", false),
                      _card("American Express", "termina con 1234", false),
                      //Scroll view implemented for more than 8 cards saved
                      /*
                      _card("Postepay", "termina con 1234", true),
                      _card("Postepay", "termina con 1234", true),
                      _card("Postepay", "termina con 1234", true),
                      _card("Postepay", "termina con 1234", true),
                      _card("Postepay", "termina con 1234", true),
                      _card("Postepay", "termina con 1234", true),*/
                    ],
                  ),
                ),
              ),
            ],
          ),
          _addCard(),
        ],
      ),
    );
  }

  Widget _buildBackButton(context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 10),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25,
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
        padding: EdgeInsets.only(top: 13),
        child: Center(
          child: Text(
            "Metodo di pagamento",
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

  Widget _infoBox() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              "Seleziona una o più preferenze di pagamento",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 17,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(primary, secondary, val) {
    return SwitchListTile(
      activeColor: Colors.deepOrange[900],
      title: Text(primary,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.height / 40,
          )),
      subtitle: Text(secondary,
          style: TextStyle(
            color: Colors.grey.shade400,
          )),
      value: val,
      onChanged: (val) {},
    );
  }

  Widget _addCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
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
                    Text(
                      "Aggiungi carta",
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                onPressed: (_onAddPressed)),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 50)
      ],
    );
  }
}
