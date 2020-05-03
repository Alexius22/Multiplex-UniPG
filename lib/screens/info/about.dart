// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

// Widget
import 'package:cinema_app/widgets/appbars/go_back_appbar.dart';
import 'package:cinema_app/widgets/buttons/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutCinema extends StatelessWidget {
  _openSiteweb() async {
    String url = "https://flutter.io";
    if (await canLaunch(url)) await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBar("Chi siamo?").build(context),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 40,
                right: MediaQuery.of(context).size.width / 40),
            child: Container(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    _image(context, 'images/cinema.jpg'),
                    _whoweare(context),
                    _buttonSiteweb(context, "Sito web"),
                    SizedBox(height: MediaQuery.of(context).size.height / 80)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _image(context, image) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Image(
        image: AssetImage(image),
      ),
    );
  }

  Widget _whoweare(context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam laoreet ultrices quam. Suspendisse interdum enim vitae odio laoreet, pulvinar vulputate eros tempor. Nulla dignissim venenatis quam a auctor. Etiam mauris nisl, consectetur varius est vitae, vulputate tincidunt sem. Sed dolor neque, tincidunt nec velit sit amet, varius ornare felis. Aenean scelerisque nunc quis quam ornare, in vestibulum dolor volutpat. Quisque sed nunc ut est varius convallis vel ut magna. Ut a convallis velit. In dapibus mi ac elit dictum, in ornare purus finibus. Vestibulum ac urna nec odio congue tincidunt. Curabitur mauris mauris, eleifend vel ex molestie, viverra venenatis augue. Nam eget sollicitudin orci. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Donec ac mi tincidunt, cursus enim quis, dignissim erat. In viverra auctor sagittis. Curabitur ornare congue felis.",
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: MediaQuery.of(context).size.height / 45,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buttonSiteweb(context, text) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
      child: CustomButton(
        width: MediaQuery.of(context).size.width / 2.8,
        text: text,
        icon: Icons.language,
        onTap: _openSiteweb,
      ),
    );
  }
}
