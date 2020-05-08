// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// Widget
import 'package:cinema_app/widgets/appbars/go_back_appbar.dart';
import 'package:cinema_app/widgets/buttons/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class CinemaAbout extends StatelessWidget {
  _openWebSite() async {
    String url = "https://flutter.io";
    if (await canLaunch(url)) await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBar("Chi siamo?").build(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 32),
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('images/cinema.jpg')),
            SizedBox(height: MediaQuery.of(context).size.height / 40),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam laoreet ultrices quam. Suspendisse interdum enim vitae odio laoreet, pulvinar vulputate eros tempor. Nulla dignissim venenatis quam a auctor. Etiam mauris nisl, consectetur varius est vitae, vulputate tincidunt sem. Sed dolor neque, tincidunt nec velit sit amet, varius ornare felis. Aenean scelerisque nunc quis quam ornare, in vestibulum dolor volutpat. Quisque sed nunc ut est varius convallis vel ut magna. Ut a convallis velit. In dapibus mi ac elit dictum, in ornare purus finibus. Vestibulum ac urna nec odio congue tincidunt. Curabitur mauris mauris, eleifend vel ex molestie, viverra venenatis augue. Nam eget sollicitudin orci. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec ac mi tincidunt, cursus enim quis, dignissim erat. In viverra auctor sagittis. Curabitur ornare congue felis.",
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: MediaQuery.of(context).size.height / 45,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 52),
            CustomButton(
              width: MediaQuery.of(context).size.width / 2.8,
              text: "Sito Web",
              icon: Icons.language,
              onTap: _openWebSite,
            ),
          ],
        ),
      ),
    );
  }
}
