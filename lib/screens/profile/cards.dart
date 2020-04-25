// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

import 'package:cinema_app/screens/profile/add_card.dart';
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
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / 4,
                //Scroll view implemented for more than 8 cards saved
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      _card("Postepay", "termina con 1234", true),
                      _card("MasterCard", "termina con 1234", false),
                      _card("American Express", "termina con 1234", false),
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
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 40,
            top: MediaQuery.of(context).size.height / 80),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: MediaQuery.of(context).size.height / 32,
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
            "Metodo di pagamento",
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height / 28.5,
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
                fontSize: MediaQuery.of(context).size.height / 47,
                color: Theme.of(context).textTheme.title.color.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(primary, secondary, val) {
    return SwitchListTile(
      title: Text(primary,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.height / 40,
          )),
      subtitle: Text(secondary,
          style: TextStyle(
            color: Theme.of(context).textTheme.title.color.withOpacity(0.5),
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
            height: MediaQuery.of(context).size.height / 16,
            width: MediaQuery.of(context).size.width / 2.05,
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
                        fontSize: MediaQuery.of(context).size.height / 40,
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
