// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// Widget
import 'package:cinema_app/widgets/buttons/button_icon.dart';

class InfoCinema extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 40,
              right: MediaQuery.of(context).size.width / 40),
          child: Column(
            children: <Widget>[
              _buildInfo(context, "Ecco dove si trova il cinema selezionato:",
                  "Via Fasulla, 1, 06123, Perugia (PG)"),
              _map(context, 'images/map.png'),
              _directions(context, "Ottieni indicazioni", null),
              _buildInfo(context, "Numero telefonico:", "0123456789"),
              _buildInfo(context, "Orari Apertura:",
                  "Giorni feriali:\n16:00 ~ 00:00\nGiorni festivi:\n15:00 ~ 01:00"),
              _siteweb(context, "Sito Web", null),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(context, description, info) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
        child: Column(
          children: <Widget>[
            Text(
              description,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: MediaQuery.of(context).size.height / 45,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              info,
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
      onTap: (func) {},
    );
  }

  Widget _siteweb(context, text, func) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
      child: ButtonWithIcon(
        width: MediaQuery.of(context).size.width / 2.8,
        text: text,
        icon: Icons.language,
        onTap: (func) {},
      ),
    );
  }
}
