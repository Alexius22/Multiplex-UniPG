// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

class InfoCinema extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            _buildInfo(context, "Ecco dove si trova il cinema selezionato:",
                "Via Fasulla, 1, 06123, Perugia (PG)"),
            _map(context, 'images/map.png'),
            _directions(context, "Ottieni indicazioni"),
            _buildInfo(context, "Numero telefonico:", "0123456789"),
            _buildInfo(context, "Orari Apertura:",
                "Tutti i giorni dalle 15:00 alle 01:00"),
            _buildInfo(context, "Sito Web:", "Link"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(context, title, choice) {
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

  Widget _map(context, image) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.05,
      height: MediaQuery.of(context).size.height / 3,
      child: Image(
        image: AssetImage(image),
      ),
    );
  }

  Widget _directions(context, text) {
    return MaterialButton(
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height / 40,
          letterSpacing: 1,
        ),
        textAlign: TextAlign.center,
      ),
      onPressed: () => {},
    );
  }
}
