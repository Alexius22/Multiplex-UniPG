// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// DB
import 'package:cinema_app/models/cinema.dart';
import 'package:cinema_app/services/cinemas.dart';

// Widget
import 'package:cinema_app/widgets/buttons/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

// Next screen
import 'package:cinema_app/transitions/slide_top_route.dart';
import 'about.dart';

class CinemaInfo extends StatelessWidget {
  final String _city;
  CinemaInfo(this._city);

  @override
  Widget build(BuildContext context) {
    // Configuration
    final TextStyle _titleStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.height / 40,
      letterSpacing: 1,
    );

    final TextStyle _infoStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: MediaQuery.of(context).size.height / 45,
      letterSpacing: 1,
    );

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            FutureBuilder<Cinema>(
              future: FirestoreCinemas().getCinemaByCity(_city),
              builder: (BuildContext context, AsyncSnapshot<Cinema> snapshot) {
                if (snapshot.hasData)
                  return Column(
                    children: <Widget>[
                      Text(
                        "Posizione della nostra sede di",
                        style: _titleStyle.copyWith(height: 0.4),
                      ),
                      Text(
                        snapshot.data.city,
                        style: _titleStyle.copyWith(
                          fontSize: MediaQuery.of(context).size.height / 30,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 4,
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.asset("images/map.png"),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: CustomButton(
                                  width:
                                      MediaQuery.of(context).size.width / 2.4,
                                  height:
                                      MediaQuery.of(context).size.height / 18,
                                  text: "Indicazioni",
                                  icon: Icons.navigation,
                                  onTap: () async {
                                    String googleUrl =
                                        'https://www.google.com/maps/search/?api=1&query=${snapshot.data.position.latitude},${snapshot.data.position.longitude}';
                                    if (await canLaunch(googleUrl))
                                      await launch(googleUrl);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Indirizzo:",
                            style: _titleStyle,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              snapshot.data.getAddress(),
                              style: _infoStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                return CircularProgressIndicator();
              },
            ),
            Divider(thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Orari Apertura",
                  style: _titleStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Costo biglietti",
                  style: _titleStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "GIORNI FERIALI:\n16:00 ~ 00:00\n\nGIORNI FESTIVI:\n15:00 ~ 01:00",
                  style: _infoStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "2D:\nIntero: €7.00\nRidotto: €5.00\n3D:\nIntero: €10.00\nRidotto: €7.00\n",
                  style: _infoStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            CustomButton(
              width: MediaQuery.of(context).size.width / 2.4,
              text: "Chi siamo",
              icon: Icons.help_outline,
              onTap: () {
                Navigator.push(
                  context,
                  SlideTopRoute(
                    page: CinemaAbout(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
