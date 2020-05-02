// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:cinema_app/transitions/slide_top_route.dart';
import 'package:flutter/material.dart';

// Widget
import 'package:cinema_app/widgets/buttons/button_icon.dart';

import 'package:cinema_app/screens/info/about.dart';

class InfoCinema extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 40,
              right: MediaQuery.of(context).size.width / 40),
          child: Column(
            children: <Widget>[
              _buildTitle2(
                  context, "Ecco dove si trova il cinema selezionato:"),
              // TODO: Cambiare la città in alto dovrebbe cambiare anche l'indirizzo
              _buildInfo2(context, "Via Fasulla, 1, 06123, Perugia (PG)"),
              _map(context, 'images/map.png'),
              _directions(context, "Ottieni indicazioni", () {}),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _buildTitle(context, "Orari Apertura"),
                      //SizedBox(width: 50),
                      _buildTitle(context, "Costo biglietti"),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _buildInfo(context,
                          "GIORNI FERIALI:\n16:00 ~ 00:00\n\nGIORNI FESTIVI:\n15:00 ~ 01:00"),
                      _buildInfo(context,
                          "2D:\nIntero: €7.00\nRidotto €5.00\n3D:\nIntero: €10.00\nRidotto €7.00\n"),
                    ],
                  ),
                ],
              ),
              _buildTitle2(context, "Numero telefonico"),
              _buildInfo2(context, "0123456789"),
              _about(context, "Chi siamo"),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(context, description) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 50,
            left: MediaQuery.of(context).size.width / 17),
        child: Column(
          children: <Widget>[
            Text(
              description,
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
      ),
    );
  }

  Widget _buildInfo(context, info) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 35),
        child: Column(
          children: <Widget>[
            Text(
              info,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: MediaQuery.of(context).size.height / 45,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle2(context, description) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            description,
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
    );
  }

  Widget _buildInfo2(context, info) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            info,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: MediaQuery.of(context).size.height / 45,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _map(context, image) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Image(
        image: AssetImage(image),
      ),
    );
  }

  Widget _directions(context, text, func) {
    return ButtonWithIcon(
      width: MediaQuery.of(context).size.width / 1.7,
      text: text,
      icon: Icons.navigation,
      onTap: func,
    );
  }

  Widget _about(context, text) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
      child: ButtonWithIcon(
        width: MediaQuery.of(context).size.width / 2.6,
        text: text,
        icon: Icons.help_outline,
        onTap: () {
          Navigator.push(
            context,
            SlideTopRoute(
              page: AboutCinema(),
            ),
          );
        },
      ),
    );
  }
}
